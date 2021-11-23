// \initclient-common.sqf

#include "defines.sqf"
#include "functions.sqf"
#include "client\defines.sqf"
#include "client\variables.sqf"
#include "client\briefing.sqf"
#include "client\AI\functions.sqf"
#include "client\actions\functions.sqf"
#include "client\markers\functions.sqf"
#include "client\markers\createMarkers.sqf"
#include "client\misc\functions.sqf"
#include "client\misc\triggers.sqf"
#include "client\respawn\functions.sqf"
#include "client\UI\functions.sqf"
#include "client\UI\onKeyPress.sqf"
#include "client\UI\onMouseMove.sqf"

query_Menu_MHQ = [
	["Accept mobilise request",false],
	["Yes",[2],"",-5,[["expression",'
		if (!MHQ_undeploy_block) then {
			_pos = getpos HQ;
			_pos set [2,1];		
			MHQ setposATL [0,-500,1.5];
			MHQ setDamage 0;
			MHQ setFuel 1;
			[MHQ,getDir HQ] remoteExecCall ["setDir",MHQ, false];
			_pos spawn {sleep 3; HQ setPosATL spawnPos; sleep 5; MHQ setPosATL _this;};	
			MHQ_undeploy_block = true;
			publicVariable "MHQ_undeploy_block";
		};
	']],"1","1"],
	["No",[3],"",-5,[["expression",'(format["%1 (%2) Denied your request to mobilise the HQ", unitID(player), getName(player)]) remoteExecCall ["hint",requestingPlayer, false];']],"1","1"]
]; 

// Grass
grasslayer = 1;
setTerrainGrid 50;

// FSM for service point (vehicle repairs etc.)
[] spawn {
	sleep 60;
	execFSM "common\fsm\ServicePoint.fsm";
};

// Respawn system
INS_lastRespawnTime = time;

if isWest then { 
	//player addRating 1000000;
	player addEventHandler ["handleDamage", { _this call handleDamage; }]; 
	player addEventHandler ["killed",{ _this call onPlayerKilled; }]; 
	player addEventHandler ["respawn",{ titleCut ["", "BLACK IN", 10]; }]; 
	player addEventHandler ["fired",{ call firedEH; }]; 
	call addActions;
}; 
if isEast then {
	player setVariable ["INS_playerString",str player, true];
	player addEventHandler ["respawn",{removeAllWeapons player;}]; 
	};
	
	
if (isServer) then { [] spawn { call compile preprocessFileLineNumbers "serverinit.sqf";};};

waitUntil {!isnil "Receiving_finish"};
sleep 1;
endLoadingScreen; 
sleep 0.3;

stuffbox addaction ["Arsenal", 
	{[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},nil,0,true,false,"","",10];

waitUntil { !(isNull (findDisplay 46)) }; 
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call onKeyPress"];
(findDisplay 46) displayAddEventHandler ["MouseMoving", "_this call onMouseMove"]; 
waitUntil { !isDead(HQ) || time > 30 };

player unlinkItem "ItemGPS";

// Hunter'z: Realism settings
onMapSingleClick "_shift";
enableSentences false;

//ACRE check
if (isMultiplayer) then {
	[] spawn {
		sleep 10;	
		if ((isnil "acre_sys_io_serverStarted") || {!acre_sys_io_serverStarted}) then {
			endMission "ACRE_disabled";
		};
	};
};
#include "client\mainLoop.sqf"