private ["_PGroup","_WCTime","_BCTime"];

//_PGroup     		= group pilotController;
_WCTime     		= time;
_BCTime                 = time;

while { true } do { 
	call westVehicleChecker;
	call aiDespawn;
	call quickCleanup;	
	call longCleanup;	
	if (livesLeft == 0 && time > 30) then {
		if (nearestPlayers(CENTERPOS,AORADIUS,true,"count") == 0) then { endMission "LOSER"; };
	};
	sleep 20;
}; 