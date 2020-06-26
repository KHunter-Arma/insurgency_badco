_vec = _this select 0;
if (typeOf _vec == "C130J_US_EP1") then {
        
	_id = _vec addaction ["<t color='#0000FF'>Load cargo</t>", "common\server\vehicles\cargoscript.sqf", ["load"],0,true,true,"","driver  _target == _this"];
	_vec setVariable ["act1",_id];
	_vec setVariable ["cargo",""];
};

/*
while {!isNil (_vec getVariable "cargo")} do {
        
        _carried = _vec getVariable "cargo";
        _dammage = getDammage _vec;
        _carried setdammage _dammage; 
        sleep 1;


};
*/

// if (((typeOf vehicle player) == "C130J_US_EP1") && (player != (driver vehicle player))) exitwith {};