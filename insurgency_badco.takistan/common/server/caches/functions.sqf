cacheKilled = { 	
    private ["_pos","_dur","_count"];
    
    _pos	= getPosATL(_this);
	curTime	= time; 
	_dur	= 5 + random 5; 
	"rhs_ammo_fab100" createVehicle _pos; 
	while{ true }do{ 
		_boom = "Sh_82mm_AMOS" createVehicle _pos; 
		_boom setPosATL _pos;
		_boom setDamage 1;
		if (random 100 > 70) then {
			_boom = "Sh_125mm_HE" createVehicle _pos;
			_boom setPosATL _pos;
			_boom setDamage 1;
		}; 
		if ((time - curTime) > _dur) exitWith {
			_boom = "rhs_ammo_fab500" createVehicle _pos;
			_boom setPosATL _pos;
			_boom setDamage 1;
		}; 
		sleep random 1; 
	}; 
	{ deleteMarker _x; } forEach cacheMarkers(_this); 
	deleteVehicle _this;
	sleep 1; 
	_count = count cacheList;
	(parseText format["%1/%2 <t color='#80FF00'>ammo cache's</t> have been destroyed!", cacheCount - _count, cacheCount]) remoteExecCall ["hint",0,false];
	if (_count == 0) then {
		["All ammo cache's have been destroyed!", "PLAIN"] remoteExecCall ["titleText",-2,true];
		sleep 20;
		endMission "END1";
	};
}; 

setupCaches = { 
	private ["_cachePos","_cacheHouse","_cache","_id","_positions","_type","_nWestUnits","_cacheHouses","_n","_m"];

	_cacheHouses = [CENTERPOS, AORADIUS, 6, true] call findHouses;
	for "_i" from 1 to cacheCount do { 	
		if DEBUG then { server globalChat format["cache%1 spawning...", _i]; };
		_cache = createVehicle [cacheType, spawnPos, [], 500, "None"];		
		_str = format ["cache%1",_i];
		[_cache, _str] remoteExecCall ["setVehicleVarName",0,true];
		missionnamespace setVariable [_str, _cache];
		publicVariable _str;
		clearWeaponCargoGlobal _cache;
		clearMagazineCargoGlobal _cache;
		_n = round (random 20);
		_cache addWeaponCargoGlobal ["rhs_weap_svdp", _n];
		_cache addWeaponCargoGlobal ["rhs_weap_akm", _n];
		//_cache addWeaponCargoGlobal ["ACE_SKS", _n];
		//_cache addWeaponCargoGlobal ["ACE_Scorpion", _n];
		_cache addWeaponCargoGlobal ["rhs_weap_rpg7", _n];
		_cache addWeaponCargoGlobal ["rhs_weap_igla", _n];
		
		_m = round ((random 40)+20);
		_cache addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1", _m];
		_cache addMagazineCargoGlobal ["rhs_30Rnd_762x39mm_bakelite", _m];
		//_cache addMagazineCargoGlobal ["ACE_10Rnd_762x39_B_SKS", _m];
		//_cache addMagazineCargoGlobal ["ACE_20Rnd_765x17_vz61", _m];
		_cache addMagazineCargoGlobal ["rhs_rpg7_PG7V_mag", _m];
		_cache addMagazineCargoGlobal ["rhs_rpg7_OG7V_mag", _m];
		_cache addMagazineCargoGlobal ["rhs_mag_9k38_rocket", _m];
		_cache addMagazineCargoGlobal ["IEDUrbanSmall_Remote_Mag", _n];
		_cache addMagazineCargoGlobal ["IEDLandSmall_Remote_Mag", _n];
		_cache addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", _n];
		_cache addMagazineCargoGlobal ["IEDLandBig_Remote_Mag", _n];
			
						
						
		_cache addEventHandler["Killed", { (_this select 0) spawn cacheKilled; }]; 
		while { count _cacheHouses > 1 } do { 
			_cacheHouse	= _cacheHouses select floor(random(count _cacheHouses - 1)); 
			_type		= typeOf _cacheHouse; 	
			_nWestUnits	= nearestObjects[getPosATL _cacheHouse, westSoldierClasses+[cacheType], cacheRadius]; 		
			if (count _nWestUnits == 0 && _type in CACHEHOUSEPOSITIONS) exitWith { 
				_id = CACHEHOUSEPOSITIONS find _type; 
				_positions = CACHEHOUSEPOSITIONS select (_id+1); 
				_cachePos = _cacheHouse buildingPos (_positions select floor(random(count _positions - 1))); 						
			}; 
			_cacheHouses = _cacheHouses - [_cacheHouse]; 
		};
		_dummy = "Land_Wrench_F" createVehicle _cachePos;
		_dummy setPosATL (_cachePos vectorAdd [0,0,1.5]);
		uiSleep 3;
		_dummy setVectorUp [0,0,1];
		uisleep 0.1;
		_cache attachto [_dummy, [0,0,1.5]]; 			
		_cacheHouse addEventHandler ["handleDamage", { 
			_damage = _this select 2; 
			_cache  = getPosATL (_this select 0) nearestObject cacheType;
			if (_damage > 0.9) then {	_cache setDamage 1;	};
			_damage
		}];
		if DEBUG then { [_cache, format["cache%1", _i]] call createDebugMarker; };		
	};
}; 	

