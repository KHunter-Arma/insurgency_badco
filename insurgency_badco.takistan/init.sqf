if (!isDedicated && hasInterface) then {
	onPreloadFinished {  
		[] spawn {		
			sleep 1;
			//startLoadingScreen ["Loading...","RscLoadScreenCustom"]; 
			startLoadingScreen ["Loading..."];
			Receiving_finish = true;
		};		
    onPreloadFinished {};    
  };
};

enableSaving [false, false]; 
waitUntil { isDedicated || !isNull player }; 
/*
waitUntil { !isNil "BIS_MPF_InitDone" }; 
waitUntil { BIS_MPF_InitDone };
*/

// Global Variable Init
curTime				= time;    //mission start time
serverLoadHint      = false;   //server load hint message

setViewDistance 3500;

//Ammobox init
stuffbox allowDamage false;
stuffbox lock false;
stuffbox setVehicleLock "UNLOCKED";

if (local player) then { call compile preprocessFileLineNumbers "initclient.sqf"; }; 
if (isServer) then { call compile preprocessFileLineNumbers "serverinit.sqf";};
