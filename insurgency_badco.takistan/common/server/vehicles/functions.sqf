westVehicleChecker = {
    private ["_vcl","_pos","_range","_driver","_plrs","_str"];
   
	
	if (!alive MHQ) exitWith {
		if ((!isnil "MHQ_isRespawning") && {MHQ_isRespawning}) exitWith {};
		MHQ_isRespawning = true;
		[]spawn {                                //Hunter'z: MHQ respawn delay
			sleep 3600;                                           
			_vcl = createVehicle [MHQTYPE, spawnPos, [], 500, "None"]; 
			[_vcl, "MHQ"] remoteExecCall ["setVehicleVarName",0,true];
			MHQ = _vcl;
			publicVariable "MHQ";
			MHQ setDir (getDir vehicleServicePoint + 90);
			HQ setDir (getDir vehicleServicePoint + 90);
			_pos = vehicleServicePoint modelToWorld [10,0,0];
			_pos set [2,0];
			if (startLocation != HQ) then {
				_pos set [2,1];
				MHQ setPosATL _pos;
			} else {
				HQ setPosATL _pos;				
				sleep 5;
				MHQ setPosATL (spawnPos vectorAdd [34,105,1.5]);					
			};			
			MHQ_isRespawning = false;			
		};	
	};
	
	
        /*
        if (!alive MHQ && startLocation == MHQ) exitWith {
                                                    
		_vcl = createVehicle [MHQTYPE, spawnPos, [], 0, "None"]; 
		_vcl setVehicleInit format["this setVehicleVarName ""%1""; %1 = this;", "MHQ"];
		processInitCommands;
		HQ setDir (getDir vehicleServicePoint + 90);
		_pos = vehicleServicePoint modelToWorld [10,0,0];
		_pos set [2,0];
		HQ setPosATL _pos;
                	
        };
        
       */ 
        
        
        
        
        
	if (startLocation != HQ) exitWith {};

	_pos = startLocation modelToWorld [3,20,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (helipad modelToWorld [0,0,0]) > 50) then {
		helipad setPosATL _pos;
		helipad setDir (getDir startLocation - 90);
	};

	_pos = startLocation modelToWorld [0,-10,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (vehicleServicePoint modelToWorld [0,0,0]) > 50) then {
		vehicleServicePoint setPosATL _pos;
		vehicleServicePoint setDir (getDir startLocation - 90);
		vehicleServicePoint setCaptive true;
	};

	_pos = vehicleServicePoint modelToWorld [-8,0,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (repairarea modelToWorld [0,0,0]) > 50) then {
		repairarea setPosATL _pos;
		repairarea setDir (getDir vehicleServicePoint);
	};
	
	_pos = startLocation modelToWorld [-3,-8,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (baseflag modelToWorld [0,0,0]) > 50) then {
		baseflag setPosATL _pos;
		baseflag setDir (getDir startLocation);
	};

	_pos = startLocation modelToWorld [8,0,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (HQ modelToWorld [0,0,0]) > 50) then {
		fieldHospital setPosATL _pos;
		fieldHospital setDir (getDir startLocation);
		fieldHospital setCaptive true;
	};

	_pos = vehicleServicePoint modelToWorld [0,4,0];
	_pos set [2,0];
	if (getMarkerPos "USFLAG" distance (stuffbox modelToWorld [0,0,0]) > 50) then {
		stuffbox setPosATL _pos;
		stuffbox setDir (getDir vehicleServicePoint - 180);
	};

	for "_i" from 0 to (count westVehicleStrings - 1) do {
		_str = westVehicleStrings select _i;
		// isNil _str check if the vehicle is undefined
		// note that, _str does NOT get wrapped in quotes because _str contains the vehicle name
		// and we are checking for the presence of the vehicle, I assume _str whill always be a valid string
		if (isNil _str) then {
			_i call resetWestVehicle;
		} else {
			_vcl = call compile _str;
			// _vcl should not be NIL here .... due to ( isNil _str) protecting us
			// but it could be anything, so ... check its an object
			if (typeName _vcl=="OBJECT") then {
				if ( isNull _vcl) then {
					_i call resetWestVehicle;
				} else {
					call checkVehiclesNearbyCampObjs;					
					if (!alive _vcl) then { 
						_i call resetWestVehicle;
					} else {
						scopeName "main";
						_range = 2000;                      //Hunter'z: limit auto-respawn for vehicles
						if (typeOf _vcl == ATVTYPE) then { 
							_range = 2000;              //Hunter'z: limit auto-respawn for vehicles
						};
						_plrs = nearestPlayers(getPosATL _vcl,SPAWNRANGE,false,"array");
						if (alive _vcl && !arrCanSee(_plrs,_vcl,45,_range) && _vcl distance startLocation > 100) then {
							_driver = driver _vcl;
							_gunner = gunner _vcl;
							if (!isNull _driver || !isNull _gunner) then { 
								if (alive _driver || alive _gunner) exitWith { 
									breakTo "main"; 
								}; 
							};
							{ moveOut _x; } forEach (crew _vcl);
							_i call resetWestVehicle;
						};	
					};
				};
			};
		};
		sleep 0.5;
	};
}; 	

// returns one specific vehicle or re-creates it at the start position
resetWestVehicle = {
	private ["_vcl","_str","_objs","_type","_bool","_pos","_dir","_id","_i","_vclKilledTime","_vclTimeDiff"];
	_i = _this;
	_str = westVehicleStrings select _i;
	if (_i > 11 || _i == -1) exitWith { }; //only return listed vehicles, but not MHQ
		_id  = _i % 6;
		_pos = baseflag modelToWorld [-9,-10+_id*8,0];
		_dir = getDir baseflag - 90;
		_type 	  = if (_id % 2 == 1) then { CAR1TYPE } else { CAR2TYPE };
	if (_i >= 6) then {
		_id = _id + 1;
		_type = ATVTYPE;
		_pos  = baseflag modelToWorld [-9,-14+_id*8,0];
	};
	if (_i == 11) then {
		_type = HELITYPE;
		_pos  = getPosATL helipad;
		_dir  = getDir helipad; 
		if (_pos distance startLocation > 100) exitWith {}; //avoid racing condition, where helipad is still at spawnPos
	};
	_pos set [2,1.5];
		
	_bool = isNil _str;
	_vcl = call compile _str;
	if !_bool then { _bool = isNull _vcl || !alive _vcl; };
	if _bool then {
		// calculate if vehicle respawn time has elapsed
		_vclKilledTime = missionNameSpace getVariable format["%1_killedTime",_str];
		if (isNil "_vclKilledTime") then { _vclKilledTime = 0; };
		_vclTimeDiff = (time - _vclKilledTime);
		if (_vclTimeDiff <= westVehicleRespawn && _vclKilledTime != 0) exitWith { /* respawn delay has not elapsed */ };
		_objs = nearestObjects[_pos,["LandVehicle","Air","CraterLong"],20];
		if (count _objs > 0) then { { if (!(_x isKindOf "AllVehicles") || !alive _x) then { deleteVehicle _x; }; } forEach _objs; };
		_vcl = createVehicle [_type, spawnPos, [], 500, "None"];
		
		[_vcl, _str] remoteExecCall ["setVehicleVarName",0,true];
		missionnamespace setVariable [_str, _vcl];
		publicVariable _str;
		
		_vcl setDir _dir;		
		_vcl setPosATL _pos;
		_vcl setVectorUp (surfaceNormal _pos);
                if (_i == 11) then { _vcl call setHeliAmmoCargo; }
                else { _vcl call setVclAmmoCargo;};
                
                /*
		if (_i < 6) then { _vcl call setVclAmmoCargo; };
		if (_i == 11) then { _vcl call setHeliAmmoCargo; };
                */
								
		// attach killed EH to define time when vehicle was killed, in order to check for respawn delay
		_vcl addEventHandler ["killed", { missionNamespace setVariable [format["%1_killedTime",(_this select 0)], time]; }];
	} else {
		_vcl call vehicleService;
		_vcl engineOn false;
		_vcl setDir _dir;
		_vcl setPosATL _pos;
	};
};

setWeaponCargo = {

	private ["_vcl","_wep","_num","_cargo","_arr1","_arr2","_count","_id"];
	_vcl   = _this select 0;
	_wep   = _this select 1;
	
	_num   = 0;
	_cargo = getWeaponCargo _vcl;
	_arr1  = _cargo select 0;
	_id    = _arr1 find _wep;
	if (_id == -1) exitWith {};
	_arr1 set[_id, str _wep];
	_arr2  = (_cargo select 1);
	_arr2 set[_id, 0];
	_cargo = [_arr1,_arr2];
	_count = count _arr2;
	clearWeaponCargoGlobal _vcl;
	for "_i" from 0 to (_count - 1) do {
		_wep = (_cargo select 0) select _i;
		_num = (_cargo select 1) select _i;
		_vcl addWeaponCargoGlobal [_wep,_num];
	};
	
};

vehicleService = {
/*
	_this call setVclAmmoCargo;
	processInitCommands;

	if (_vcl == heli) then {
	_this call setHeliAmmoCargo;
	processInitCommands;
};
*/

	_this call setVclAmmoCargo;
	if (!isnil "heli" && {_vcl == heli}) then {
		_this call setHeliAmmoCargo;
	};
};

setVclAmmoCargo = {
	_this setVehicleAmmo 1;
	_this setFuel 1;
	_this setDamage 0;
	clearWeaponCargoGlobal _this;
	clearMagazineCargoGlobal _this;
	clearItemCargoGlobal _this;
	clearBackpackCargoGlobal _this;
	{ _this addMagazineCargoGlobal [_x select 0, _x select 1]; } forEach humvMagazines;
	{ _this addItemCargoGlobal [_x select 0, _x select 1]; } forEach humvItems;
	if (player in crew _this) then { titleText["Vehicle serviced", "PLAIN DOWN"]; };
	
};

setHeliAmmoCargo = {

	_this setVehicleAmmo 1;
	_this setFuel 1;
	_this setDamage 0;
	clearWeaponCargoGlobal _this;
	clearMagazineCargoGlobal _this;
	clearItemCargoGlobal _this;
	clearBackpackCargoGlobal _this;
	{ _this addMagazineCargoGlobal [_x select 0, _x select 1]; } forEach heliMagazines;
	{ _this addItemCargoGlobal [_x select 0, _x select 1]; } forEach heliItems;
	if (player in crew _this) then { titleText["Heli serviced", "PLAIN DOWN"]; };

};

checkVehiclesNearbyCampObjs	= {

	_isemptycar = isnil "heli" || {_vcl!=heli && {({alive _x && {isPlayer _x}} count crew _vcl) == 0}};
	_campObjArray = ["M1130_HQ_unfolded_Base_EP1","MASH_EP1","US_WarfareBVehicleServicePoint_Base_EP1","Land_BagBunker_Small_F"];
	_isemptyheli = isnil "heli" || {_vcl==heli && {({alive _x && {isPlayer _x}} count crew _vcl) == 0}};

	if (_isemptycar && _vcl distance (fieldHospital modelToWorld [0,0,0]) < 2) then {
	_vcl setPos [(getPos _vcl select 0) + 3,
	(getPos _vcl select 1) + 3,
	(getPos _vcl select 2)]};

	if (_isemptycar && _vcl distance (vehicleServicePoint modelToWorld [0,0,0]) < 1) then {
	_vcl setPos [(getPos _vcl select 0) + 2,
	(getPos _vcl select 1) + 2,
	(getPos _vcl select 2)]};

	if (_isemptycar && _vcl distance (helipad modelToWorld [0,0,0]) < 7) then {
	_vcl setPos [(getPos helipad select 0) - 10,
	(getPos helipad select 1) + 1,
	(getPos helipad select 2)]};

	if (_isemptycar && _vcl distance (HQ modelToWorld [0,0,0]) < 6) then {
	_vcl setPos [(getPos _vcl select 0) + 0.5,
	(getPos _vcl select 1) - 6,
	(getPos _vcl select 2)]};
	
	if (HQ distance (helipad modelToWorld [0,0,0]) < 10) then {
	HQ setDir (getDir vehicleServicePoint + 90);
	_pos = vehicleServicePoint modelToWorld [10,0,0];
	_pos set [2,0];
	HQ setPosATL _pos;};
	
};
