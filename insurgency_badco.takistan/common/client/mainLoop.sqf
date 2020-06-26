private ["_sign","_weapons","_oldPlayerGroup","_playerGroupMembers","_pos","_oldUnit","_Block","_A10Timer","_c","_ctrlText","_PlayerGroup","_HQstate", "_dir", "_xpos", "_ypos", "_vector"]; 
call disableSerialization; 

_Block     	= 10;
_A10Timer	= time;
//_ArtyTimer 	= time;   // arty is definitely an overkill in Insurgency
_PlayerGroup 		= grpNull;
_HQstate 			= startLocation;

if isEast then {
	eastSpawnPos = getMarkerPos "respawn_east";
	eastPlayer = player;
	removeAllWeapons player;
};

/*
if isWest then {
	[] spawn {
		sleep 60;
		call disableSerialization; 
		while { true } do {
			//UI
			call playerTags;  
			call vehicleTags;
                        sleep 0.1;
		};
	};
};
*/

if isWest then {
	[] spawn { 
		_aiTimer = time;
		while { true } do {
			//AI			
			call aiSpawn;
			//if (time - _aiTimer > 30) then { _aiTimer = time + (random 10) - 5; };
			//call groupAI;
			sleep 1;
			call aiMonitor; 
			sleep (25 + (random 10));
		};
	};
};

_playergrp = grpNull;
while { isWest } do { 

	//Markers
	call gridPath;
	if (markersEnabled == 1) then {
		call playerMarkers; 
		call vehicleMarkers; 
		call markerTexts;
	}; 

	//Misc
	call clearHouses;
	call casePickup;
	call nameStrings;
	if (_HQstate != startLocation) then { 
		if (_HQstate == HQ) then { hint "HQ mobilised!"; } else { hint "HQ deployed!"; "USFLAG" setMarkerPos startPos;    
			};
		_HQstate = startLocation; 
	};
	if (getMarkerPos "USFLAG" distance (fieldHospital modelToWorld [0,0,0]) > 50) then {
		"USFLAG" setMarkerPos (fieldHospital modelToWorld [0,0,0]);
	};	
	
	//Respawn
	if (isDead(player) && isNull respawnCamera) then { [] spawn respawnSystem; };
	if (livesLeft == 0 && time > 30) then {
		if (nearestPlayers(CENTERPOS,AORADIUS,true,"count") == 0) then { endMission "LOSER"; };
	};
	
	// check to see if a player logged in as admin
	isAdmin = serverCommandAvailable "#kick";

	sleep 0.1; 
}; 

while { isEast } do { 

	//Markers
	call AImarkers;
	call markerTexts;

	//Respawn
	if (isDead(player) && !visibleMap) then { 
		hintSilent "To start playing, open your map and click on the ai unit you wish to become.
You can switch units at any time during the game by doing this. If there are no ai units visible on the map
it means no blufor players are near hostile areas and so no ai have spawned. In this case either wait awhile or join
the blufor team.";
	};
	if (!alive player && player != eastPlayer) then { 
	
		// respawn delay for east players
		if (INS_dynamicRespawn == 1) then {
			// no dynamic respawn for east players
			_c = 120;
		} else {
			_c = INS_dynamicRespawn;
		};
		
		waitUntil {
			cutRsc["Rtags", "PLAIN"];
			_ctrlText = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64434; 	
			_ctrlText ctrlSetStructuredText parseText format[
				"<t color='%2' shadow='1' shadowColor='#000000'>Respawn in %1</t>"
			, abs ceil _c, "#FFFFFF"]; 								
			_c = _c - 0.1;
			sleep 0.1;
			(ceil _c) <= 0
		};
		_oldUnit = player; 
		selectPlayer eastPlayer; 
		[_oldUnit] joinSilent oldGroup; 
	};
	if (player distance eastSpawnPos > 10 && isDead(player)) then { player setPosATL eastSpawnPos; };
	if (player distance startPos < hqProtectionRing && !isDead(HQ)) then { 
		_pos = getPosATL player;
		_dir = getDirTo(player, startPos);
		if (_dir < 0) then { _dir = 360 + _dir; };
		_vector = [sin(_dir),cos(_dir)];
		_xpos	= (_pos select 0) - (_vector select 0);  
		_ypos	= (_pos select 1) - (_vector select 1);
		_pos 	= [_xpos,_ypos,0];
		player setPosATL _pos; 
		hintSilent "You are not allowed near the enemy's main base.";
	};
	
	//UI
	//call eastPlayerTags;

	sleep 0.1; 
}; 
	