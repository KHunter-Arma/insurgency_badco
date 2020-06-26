private ["_trg"];

_trg = createTrigger ["EmptyDetector", position player, false]; 
_trg setTriggerText "Ammo Caches Left"; 
_trg setTriggerActivation ["ALPHA", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
	hint parseText format["
		%1/%2 <t color=""#80FF00"">ammo cache''s</t> have been destroyed.
		",cacheCount - count cacheList, cacheCount]
', ""]; 
 
_trg = createTrigger ["EmptyDetector", position player, false]; 
_trg setTriggerText "Player Identities"; 
_trg setTriggerActivation ["BRAVO", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
	_str = ""; 
	{ 
		if (!isNil _x) then { 
			_plr	 = call compile _x; 
			if !isNull _plr then {
				_color = "#0000FF"; 
				if (str _plr in squadUnitStrings(squadString(player))) then { _color = "#00FF00"; }; 
				_str = _str + format["
					<t align=""center""><t color=""%1"">%2</t>: %3<br/><br/></t>
				", _color, unitID(_plr), getName(_plr)]; 
			};
		}; 
	} forEach westPlayerStrings; 
	hint parseText _str; 		
', ""]; 

_trg = createTrigger ["EmptyDetector", position player, false]; 
_trg setTriggerText "Unflip Vehicle"; 
_trg setTriggerActivation ["GOLF", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
_vehicle = vehicle player;
if (player != _vehicle) then {
	_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 0.5];
	_vehicle setVelocity [0,0,-0.5];
};
if (player == _vehicle) then {
	_objects = player nearEntities[["Car","Motorcycle","Tank"],5];
	{	
		if (count _objects > 0) then {		
			_x setPos [getPos _x select 0, getPos _x select 1, 0.5];
			_x setVelocity [0,0,-0.5];
		};
	} forEach _objects;
};
', ""]; 

if (startLives > -1) then {
	deleteVehicle _trg; 
	_trg = createTrigger ["EmptyDetector", position player, false]; 
	_trg setTriggerText "Lives remaining"; 
	_trg setTriggerActivation ["GOLF", "PRESENT", true]; 
	_trg setTriggerStatements ["this", '
	hint parseText format["
		<t color=""#00FFFF"">Blufor lives remaining:</t> %1
		",livesLeft];
	', ""]; 
};

_trg = createTrigger ["EmptyDetector", position player, false]; 
_trg setTriggerText " "; 
_trg setTriggerActivation ["HOTEL", "PRESENT", true]; 

_trg = createTrigger ["EmptyDetector", position player, false]; 
_trg setTriggerText " "; 
_trg setTriggerActivation ["INDIA", "PRESENT", true]; 

if DEBUG then { 
	deleteVehicle _trg; 
	_trg = createTrigger ["EmptyDetector", position player, false]; 
	_trg setTriggerText "teleport"; 
	_trg setTriggerActivation ["INDIA", "PRESENT", true]; 
	_trg setTriggerStatements ["this", 'hint "Click on map to select teleport destination"; onMapSingleClick "player setPosATL _pos; onMapSingleClick """"; hint ""Teleported!"" " ',""]; 
}; 

showRadio true; 