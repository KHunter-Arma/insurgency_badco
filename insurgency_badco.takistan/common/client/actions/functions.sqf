addActions = { 
	//check if MHQ damaged - remove deploy action
	_hqdamaged = ((damage MHQ)>0.9);
	if (!alive MHQ && _hqdamaged) then { player removeAction actionHQDeploy; actionHQDeploy = nil; };
	
	if !isNil "actionHQDeploy" then { player removeAction actionHQDeploy; actionHQDeploy = nil; };
	actionHQDeploy = player addAction ["Deploy HQ","common\client\actions\noScript.sqf",'
	if (!MHQ_undeploy_block) then {
	MHQ_undeploy_block = true;
	publicVariable "MHQ_undeploy_block";
	_campArray = ["Land_HelipadCircle_F","MASH_EP1","US_WarfareBVehicleServicePoint_Base_EP1","Land_BagBunker_Small_F"];
	_houseArray = ["HouseBase"];
	_checkHouseCount = (nearestObjects [MHQ, _houseArray, 30]) - (nearestObjects [MHQ, _campArray, 30]);
	
   if (count _checkHouseCount == 0) then {
		_pos = getPosATL MHQ;
		if (count (_pos isFlatEmpty [0,0,0.2,20,0,false,MHQ]) == 0) exitWith { hint "Cannot deploy here. The terrain is unsuitable"; };
		{ moveOut _x } forEach crew MHQ;
		HQ setDir getDir MHQ;	
		MHQ setposATL [0,-500,1.5];
		sleep 3;
		_pos set [2,0];
		HQ setPosATL _pos;
		sleep 5;
		MHQ setPosATL (spawnPos vectorAdd [34,105,1.5]);
		HQ setVariable ["hqdT",time,true];
	} else {hintsilent "You cant deploy HQ near buildings!";};
	};
	',1,false,true,"",'vehicle _target == _target && _target distance MHQ < 4'];
	
	if !isNil "actionCampfire" then { HQ removeAction actionCampfire; actionCampfire = nil; };
	actionCampfire = HQ addAction ["Light fire","common\client\actions\noScript.sqf",'
		_pos = player modelToWorld [0,-2,0];
		_pos set [2,0];
		campfire setpos _pos;
	',-9,false,true,"",''];
	
	if !isNil "actionHQMobilise" then { HQ removeAction actionHQMobilise; actionHQMobilise = nil; };
	actionHQMobilise = HQ addAction ["Mobilise HQ","common\client\actions\noScript.sqf",'
		if (lifeState player == "UNCONSCIOUS") exitWith {};
		if (mhqDeployTimer == -1) exitWith { hintsilent "The HQ is bolted in place, you cannot redeploy!"; };
		_timePassed = HQ getVariable ["hqdT",0]; 
		_dT = mhqDeployTimer - (time - _timePassed);
		if (_dT > 0 && _timePassed != 0) exitWith { hintsilent format ["You have to wait approx. %1 minutes to mobilize the MHQ.", (round((abs _dT)/60))]; }; 
		_leader = call compile squadLeader(player);
		_str = "You need a squad leader to mobilise the HQ";
		if (isNil "_leader") exitWith { hintsilent _str; };
		if (isNull _leader || !isPlayer _leader) exitWith { hintsilent _str; };
		if (!alive _leader || isDead(_leader)) exitWith { hintsilent "Your squad leader is dead!"; };
		hintsilent format["Sent request to %1 (%2).", unitID(_leader), getName(_leader)];		
		[missionNamespace, ["requestingPlayer", player]] remoteExecCall ["setVariable",_leader,false];
		sleep 5;
		"#USER:query_Menu_MHQ" remoteExecCall ["showCommandingMenu",_leader,false];
		(format["%1, (%2) is requesting permission to mobilise the HQ. Accept?", unitID(player), getName(player)]) remoteExecCall ["hint",_leader,false];
	',1,false,true,"",''];
	
	if !isNil "actionBagsDeploy" then { player removeAction actionBagsDeploy; actionBagsDeploy = nil; };
	actionBagsDeploy = player addAction ["Deploy nest","common\client\actions\noScript.sqf","
		_cT = cursorTarget;
		_bags = call compile format[""bags%1"", _cT];
		_pos = _cT modelToWorld [0,-5,0];
		_bags setDir (getDir _cT);
		_bags setPosATL [_pos select 0,_pos select 1,0];
	",1,false,true,"",'
		_cT = cursorTarget; 		
		if !isNull _cT then { 
			if (!(typeOf _cT in (westVehicleClasses-[ATVTYPE]-[HELITYPE])) || !alive _cT) exitWith {};
			_pos = _cT modelToWorld [0,-3,0];
			_bags = call compile format["bags%1", _cT];
			alive _cT && player distance _pos < 3 && _bags distance spawnPos < 50
		};
	'];

         
	
	if !isNil "actionBagsLoad" then { player removeAction actionBagsLoad; actionBagsLoad = nil; };
	actionBagsLoad = player addAction ["Load nest","common\client\actions\noScript.sqf","
		cursorTarget setPosATL [0,0,0];
	",1,false,true,"",'
		_cT = cursorTarget; 		
		if !isNull _cT then { 
			if !(typeOf _cT == "Land_BagBunker_Small_F") exitWith {};
			_vcl = call compile format["humv1%1", unitNumber(_cT)];
			player distance _cT < 3 && _cT distance _vcl < 10
		};
	']; 
		
	
	if !isNil "actionRearm" then { player removeAction actionRearm; actionRearm = nil; };
	actionRearm = player addAction ["Rearm stationary weapon","common\client\actions\noScript.sqf","
	_vcl = cursorTarget;
	hintsilent ""rearming..."";
	player playMove ""ainvpknlmstpslaywrfldnon_medic"";
	curTime = time;
	waitUntil{ animationState player == ""ainvpknlmstpslaywrfldnon_medic""};  
	waitUntil{ animationState player != ""ainvpknlmstpslaywrfldnon_medic""}; 
	if (time - curTime > 7) then { _vcl setVehicleAmmo 1; };
	",1,false,true,"",'
	_cT = cursorTarget;
	if !isNull _cT then { _cT isKindOf "staticWeapon" && alive _cT }
	']; 

	if !isNil "doRepairVecs" then { player removeAction doRepairVecs; doRepairVecs = nil; };
	doRepairVecs = player addAction ["Repair Vehicles","common\client\actions\noScript.sqf",'
		_timePas = HQ getVariable ["RepVecs",0];
		_rT = 60 - (time - _timePas);
		if (_rT > 0 && _timePas != 0) exitWith { hintsilent format ["You have to wait approx. %1 minutes to repair vehicles near MHQ.", (round((abs _rT)/60))]; };
	_gleader = call compile squadLeader(player);
		_str = "Only squad leader can repair vehicles near HQ!";
		if (isNil "_gleader") exitWith { hintsilent _str; };
		if (isNull _gleader || !isPlayer _gleader) exitWith { hintsilent _str; };
	for "_i" from 0 to (count westVehicleStrings - 1) do {
		_str = westVehicleStrings select _i;
		_vcl = call compile _str;
	if (typeName _vcl=="OBJECT") then {
		if (damage _vcl < 0.99 && _vcl distance (baseflag) < 40 && !(player in _vcl)) then {
		_vcl setDamage 0;
		hintsilent "Vehicles Repaired!";
		HQ setVariable ["RepVecs",time,true];
		};
	};
};
',1,false,true,"",'
vehicle _target == _target && _target distance HQ < 7
	'];

}; 



addActionWearBelt = {
	if !isNil "CanWearBelt" then { _this removeAction CanWearBelt; CanWearBelt = nil; };
	CanWearBelt = _this addAction ["Wear belt","common\client\actions\noScript.sqf",'
	if !isNil ((_this select 0) getVariable "BeltWorn") exitWith {} ; 
	_this select 0 removeAction (_this select 2);
	_this select 0 removeMagazine "IEDLandSmall_Remote_Mag";
	_this select 0 setVariable ["BeltWorn",1,true];
	_this select 0 call addActionDisarmBelt;
	_this select 0 call addActionExplodeBelt;
 ',1,false,true,"",'
 //check if player have ied in inventory
 _haveIED = magazines _this;
 _magIED = "IEDLandSmall_Remote_Mag";
 _magIED in _haveIED
	'];
		};

addActionDisarmBelt = {
	CanDisarmBelt = _this addAction ["Disarm belt","common\client\actions\noScript.sqf",'
	_this select 0 removeAction (_this select 2);
	_this select 0 setVariable ["BeltWorn",nil];
	_this select 0 addMagazine "IEDLandSmall_Remote_Mag";
	_this select 0 removeAction CanExplodeBelt;
	_this select 0 call addActionWearBelt;
 ',1,false,true,"",""];
		};
		
addActionExplodeBelt = {
	CanExplodeBelt = _this addAction ["Explode belt!","common\client\actions\noScript.sqf",'
	_this select 0 removeAction (_this select 2);
	_this select 0 removeAction CanDisarmBelt;
	_this select 0 setVariable ["BeltWorn",nil];
	"Sh_125_HE" createVehicle getPos (_this select 0);

 ',1,false,true,"",'
 !isNil{_this getVariable "BeltWorn"}
 '];
	};
