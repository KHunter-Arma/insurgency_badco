_vehicle = _this select 0;
_caller = _this select 1;
_actionarray = _this select 3;
_action = _actionarray select 0;
_carrier = _this select 0;
_loadpos = _carrier ModelToWorld [0,-13,-5.5];
_cargo = _carrier getVariable "cargo";
_act1 = _carrier getVariable "act1";
_carried = objNull;

if (((typeOf vehicle player) == "C130J_US_EP1") && (player != (driver vehicle player))) exitwith {};

if (_action == "load") then {
	if (_cargo == "") then {
		_near = nearestObjects [_loadpos, ["Land","Ship"], 8];
		_obj = _near select 0;
		_bound = boundingBox _obj;
		
		_width = (_bound select 1 select 0) - (_bound select 0 select 0);
		_length = (_bound select 1 select 1) - (_bound select 0 select 1);
		_height = (_bound select 1 select 2) - (_bound select 0 select 2);
		
		if (count _near > 0) then {
			player sidechat format ["x:%1 y:%2 z:%3",_width,_length,_height];
			if ((_width <= 10.0) && (_length <= 22) && (_height <= 12)) then {
				_carrier setVariable ["cargo",_obj];
				_carrier removeAction _act1;
				player sideChat format ["Loading %1 into cargo",typeOf _obj];
                                player sideChat "REMEMBER YOU MUST DROP IT FROM A HIGH ALTITUDE (AT LEAST 600)";
				_carrier animate ["ramp_top", 1];
				_carrier animate ["ramp_bottom", 1];
                                if((count (crew _obj)) != 0) then {{moveout _x; _x moveinCargo _carrier;} forEach (crew _obj);};
				sleep 3;
				_obj attachTo [_carrier,[0,2,((_obj modelToWorld [0,0,0]) select 2)-4.5]];
                                _carried = _obj;
				_obj setVariable ["evh",_id];
				_obj setVariable ["carrier",_carrier];
				sleep 2;
				_carrier animate ["ramp_top", 0];
				_carrier animate ["ramp_bottom", 0];
				sleep 1;
				_id = _carrier addaction ["<t color='#0000FF'>Unload</t>", "common\server\vehicles\cargoscript.sqf", ["drop"],0,true,true,"","driver  _target == _this"];
				_carrier setVariable ["act1",_id];
                                
			} else {
				player sideChat "This won't fit in the cargospace";
			};
		} else {
			player sideChat "Nothing in range";
		};
	} else {
		player sideChat "Cargo is already full";
                if((count crew _cargo) != 0) then {{_x moveinCargo _carrier;} forEach crew _cargo;};
	};
        
};

if (_action == "drop") then {
	_carrier removeAction _act1;
	_id = _cargo getVariable "evh";
	_cargo removeEventHandler ["GetOut", _id];
        _carrier animate ["ramp_top", 1];
	_carrier animate ["ramp_bottom", 1];
	sleep 3;
	if ((getpos _carrier select 2) > 3) then {
                //_droppos = _carrier ModelToWorld [0,-15,-12];
                _droppos = player ModelToWorld [0,-18,-12];
                _cargo setpos _droppos;
		detach _cargo;
		_cargo setpos _droppos;
                _cargo setVelocity (velocity _carrier);
                _cargo setDir (getDir _carrier);
		sleep 3;
		_carrier animate ["ramp_top", 0];
		_carrier animate ["ramp_bottom", 0];
                sleep 10;
		_chute = "ParachuteBigWest" createVehicle getpos _cargo;
		_chute setpos (_cargo ModelToWorld [0,0,3]);
                _chute setVelocity (Velocity _cargo);
		_cargo attachTo [_chute,[0,0,0]];
	} else {
		detach _cargo;
		_cargo setpos _loadpos;
		sleep 2;
		_carrier animate ["ramp_top", 0];
		_carrier animate ["ramp_bottom", 0];
	};
        
	_carrier setVariable ["cargo",""];
	_id = _carrier addaction ["<t color='#0000FF'>Load cargo</t>", "common\server\vehicles\cargoscript.sqf", ["load"],0,true,true,"","driver  _target == _this"];
	_carrier setVariable ["act1",_id];

};
