params ["_flag", "_flagSpeakers"];

[_flag] call gradSB_fnc_flagAddAction;

if (isServer) then {
    _flag setFlagTexture "";
    _flag setVariable ["gradSB_flagSpeakers", _flagSpeakers, true];
};