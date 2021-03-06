createHeliPilot = {
	call compile format['
		%1 = _PGroup createUnit [PILOTTYPE, spawnPos, [], 0, "NONE"];
		%1 setVehicleVarName "%1";
		%1 setCaptive true;
		%1
	', _this];
};

pilotAI = {	
	private ["_pilot","_stopped","_landing","_movePos","_units","_vcl"];
	
	_pilot = "heliPilot";
	if isNil _pilot then { _pilot call createHeliPilot; };
	_pilot = call compile _pilot;
	if isNull _pilot then { 
		// null objects can't be re-used in SQF
		_pilot = "heliPilot"; 
		_pilot call createHeliPilot; 
	};
	if !alive _pilot then { deleteVehicle _pilot; _pilot = _pilot call createHeliPilot; };	
	_units = units group _pilot;	
	if (!(pilotController in _units) && count _units == 1) then {	[_pilot] join _PGroup; };
	_vcl = vehicle _pilot;
	if (_vcl == _pilot) then {
		if (alive heli && heli distance startPos < 300) then { 
			heli setDamage 0;
			heli setFuel 1;
			heli lockDriver false;
			_pilot assignAsDriver heli;				
			_pilot moveInDriver heli; 
			heli lockDriver true;				 
		};
	} else {
		_stopped = _vcl getVariable "stopped";
		_landing = _vcl getVariable "landing";
		if !(pilotController in _units) exitWith {
			if !isNil "_stopped" then { _vcl setVariable ["stopped", nil]; };
			if !isNil "_landing" then { _vcl setVariable ["landing", nil]; };
		};		
		if (getPosATL _vcl select 2 < 5 && count crew _vcl > 1 && isEngineOn _vcl) exitWith {
			if !isNil "_stopped" exitWith {};
			doStop _pilot;
			_vcl flyInHeight (getPosATL _vcl select 2);
			_vcl setVariable ["stopped", true];
		};
		if !isNil "_stopped" then { _vcl setVariable ["stopped", nil]; };
		_movePos = expectedDestination _pilot select 0;
		if (_movePos select 0 == 0 && _vcl distance helipad > 200) exitWith { 
			_vcl flyInHeight 30; 
			_vcl doMove getPosATL helipad; 
		};		
		if (_vcl distance helipad <= 200 && isEngineOn _vcl) exitWith { 
			if (getPosATL _vcl select 2 < 2) exitWith { _pilot action ["EngineOff", _vcl];  };
			if !isNil "_landing" exitWith {};
			_vcl land "land"; 
			_vcl setVariable ["landing", true];
		};
		if !isNil "_landing" then { _vcl setVariable ["landing", nil]; };
	};
};


// Hunter'z: edited to spawn with passengers if possible
spawnAIVehicle = {
	private ["_num","_track","_speed","_grp","_type","_obj","_mkr","_pos","_vcl","_ai","_unum"];
	_unum = _this;
	waitUntil {sleep 3; (count playableUnits) > 0};
	_num	= _unum % 3; 
	if (_num == 0) then { _num = 3; }; 
	//_grp	= ["","vclGrp",_unum+1,"east"] call getGroup; 
	_grp = createGroup east;
	_type = eastVehiclesFreq select round(random (count eastVehiclesFreq - 1)); 		
	_obj 	= call compile ("vclSpawn" + str(_num)); 
	_mkr 	= str _unum; 
	_pos 	= getPosATL _obj; 
	_vcl 	= createVehicle [_type, _pos, [], 100, "None"];
	_vcl setPosATL ((getPosATL _vcl) vectorAdd [0,0,1]);
	_vcl setVectorUp (surfaceNormal _pos);	
	// Hunter: anti-bad driving fix (does not cover flipping...)
	_vcl addEventHandler ["HandleDamage",{
		_return = _this select 2;
		_source = _this select 3;
		_unit = _this select 0;		
		if (((_this select 4) == "") && {(isnull _source) || {((side _source) getFriend (side _unit)) >= 0.6}}) then {
			_return = 0;
		};
		_return 
	}];
	
	if (DEBUG) then { server globalChat format["AI VEHICLE %1 of TYPE %2 CREATED! POSITION: %3", _unum, str _vcl, str _pos]; };
	_vcl setDir getDir _obj;
	
	_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
	_ai setVariable ["auxAI", true];
	_ai setRank (eastRanks select 2); 
	_ai setSkill (aiSkill/10);
	_ai setSkill ["spotDistance",1];	
	_ai setSkill ["spotTime",1];
	_ai moveInDriver _vcl;
	
	if (typeOf _vcl in withPassenger) then {
				
		{
			_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
			_ai setVariable ["auxAI", true];		
			_ai setRank (eastRanks select 4); 
			_ai setSkill (aiSkill/10);
			_ai moveInTurret [_vcl, _x];
		} foreach (allTurrets [_vcl, true]) - (allTurrets [_vcl, false]);
		
		sleep 0.1;
		_cargoSeats = _vcl emptyPositions "Cargo";
		if (_cargoSeats > 0) then {
			for "_i" from 1 to _cargoSeats do {
				_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
				_ai setVariable ["auxAI", true];		
				_ai setRank (eastRanks select 4); 
				_ai setSkill (aiSkill/10);
				_ai moveInCargo _vcl;
				sleep 0.05;
			};
		};
		
		_vcl setUnloadInCombat [true,true];

	}; 
	
	{
		_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
		_ai setVariable ["auxAI", true];		
		_ai setRank (eastRanks select 0);
		_ai setSkill (aiSkill/10);
		_ai setSkill ["spotDistance",1];	
		_ai setSkill ["spotTime",1];	
		_ai moveInTurret [_vcl, _x];
	} foreach allTurrets [_vcl, false];

	if !(typeOf _vcl in eastLightVehicles) then {
		_vcl lockDriver true;
		_vcl lockTurret [[0], true];
	};
	_speed = "slow"; 
	_track = ""; 
	if (DEBUG) then { _track = "track"; }; 
	if (typeOf _vcl in eastLightVehicles) then { _speed = "noslow"; }; 
	_grp deleteGroupWhenEmpty true;
	sleep 1;
	cleanupVics pushBack _vcl;
	[leader _grp, _mkr, _speed, "nowait", _track] execVM "common\server\AI\UPS.sqf";
};

spawnAIVehicles = { 
	private "_num";

	for "_i" from 1 to eastVehicleNum do { 		
		_i call spawnAIVehicle;
		if (DEBUG) then { server globalChat format ["SPAWNING AI VEHICLE %1", _i]; };
		sleep 120; 
	};
}; 	
if (INS_Roofguns == 1) then {
	spawnAIGuns = { 
		private ["_id","_gCount","_house","_houses"]; 
		
		_houses = [CENTERPOS,AORADIUS, 4, true] call findHouses; 	
		_gCount	= 0; 
		while{ _gCount < maxStaticGuns && count _houses > 0} do{ 
			_house = _houses select random(count _houses - 1); 
			_id	   = GUNROOFPOSITIONS find (typeOf _house); 
			if (_id != -1 && _house distance startLocation > 500) then { 
				if (count nearestObjects[getPosATL _house, eastStationaryGuns, staticWepDistances] == 0) then { 
					[_id, _house, _gCount] call createRoofGun; 	
					_gCount = _gCount + 1; 
				}; 
			}; 
			_houses = _houses - [_house]; 		
		}; 
		
		_gCount
	}; 

	createRoofGun = { 	
		private ["_class","_pos","_housePositions","_id","_housePosition","_classId","_gun","_house","_dir","_grp","_gCount","_ai"]; 
		_id		= _this select 0;
		_house	= _this select 1;
		_gCount = _this select 2;
		
		_housePositions = GUNROOFPOSITIONS select (_id+1); 
		_housePosition  = (_housePositions select random (count _housePositions - 1)) select 0; 
		_classId        = (_housePositions select random (count _housePositions - 1)) select 1; 
		if (_classId <= 0.2) then { _class = stationaryGunsLow select random(count stationaryGunsLow - 1); }; 
		if (_classId > 0.2 && _classId < 0.5) then { _class = stationaryGunsMed select random(count stationaryGunsMed - 1); }; 
		if (_classId >= 0.5) then { _class = stationaryGunsHigh select random(count stationaryGunsHigh - 1); }; 
		_gun = createVehicle [_class, spawnPos, [], 500, "None"]; 
		for "_j" from 0 to 10 do { _gun addMagazine (magazines _gun select 0); };	
		_dir = ((boundingCenter _house select 0) - (getPosATL _gun select 0)) atan2 ((boundingCenter _house select 1) - (getPosATL _gun select 1)); 
		_dir = (360 - _dir); 
		//_dir = ((getPosATL startLocation select 0) - (getPosATL _gun select 0)) atan2 ((getPosATL startLocation select 1) - (getPosATL _gun select 1)); 
		_pos = _house buildingPos _housePosition;
		_dummy = "Land_Wrench_F" createVehicle _pos;
		_dummy setDir _dir;
		_dummy setPosATL (_pos vectorAdd [0,0,2]);
		uiSleep 3;
		_dummy setVectorUp [0,0,1];
		uisleep 0.1;
		_gun attachto [_dummy, [0,0,1.5]]; 		
		_dirOffset = -(getDir _dummy);
		private _maxAngle = getnumber (configfile >> "cfgvehicles" >> (typeof _gun) >> "Turrets" >> "MainTurret" >> "maxTurn");
		if (_maxAngle < 180) then {
			_maxAngle = (_maxAngle - 15) max 5;
			[_gun, _maxAngle, _dirOffset] spawn {
				params ["_gun", "_maxAngle","_dirOffset"];
				while {true} do {
					sleep 10;
					_gunner = gunner _gun;
					if (!alive _gunner) exitWith {};
					if ((lifeState _gunner) != "UNCONSCIOUS") then {
						_target = assignedTarget _gunner;
						if (!isnull _target) then {
							_bearing = ([_gun,_target] call BIS_fnc_dirTo) % 360;
							if ((abs ((getdir _gun) - _bearing)) > _maxAngle) then {
								_gun setDir (_dirOffset + _bearing);
							};
						};
					};
				};
			};
		};		
		_grp = ["static","Grp",str _gCount,"east"] call getGroup; 
		_ai  = _grp createUnit [staticClass, spawnPos, [], 100, "NONE"];	
		_ai setVariable ["auxAI", true];
		_ai assignAsGunner _gun; 
		_ai moveInGunner _gun;	
		_grp setFormDir _dir;
		_ai setSkill (aiSkill/10);
		_ai setSkill ["spotDistance",1];
		if DEBUG then { [_house, _ai] call createDebugMarker; };  		
	}; 
};