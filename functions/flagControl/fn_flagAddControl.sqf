params ["_flag", "_flagSpeakers"];

[_flag] call gradSB_fnc_flagAddAction;

if (isServer) then {
    _flag setFlagTexture "";
    _flag setVariable ["gradSB_flagSpeakers", _flagSpeakers, true];

    // count points
    [{
        params ["_args", "_handle"];
        _args params ["_flag"];

        private _flagOwner = _flag getVariable ["gradSB_flagOwner", sideUnknown];
        ["gradSB_points", ["flag", _flagOwner]] call CBA_fnc_serverEvent;

    }, 60, [_flag]] call CBA_fnc_addPerFrameHandler;
};