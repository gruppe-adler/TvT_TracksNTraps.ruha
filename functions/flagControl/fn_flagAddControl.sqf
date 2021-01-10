params ["_flag", "_flagSpeakers"];

[_flag] call gradTnT_fnc_flagAddAction;

if (isServer) then {
    _flag setFlagTexture "";
    _flag setVariable ["gradTnT_flagSpeakers", _flagSpeakers, true];

    missionNamespace setVariable ["gradTnT_flagObjective", _flag, true];

    // count points
    [{
        params ["_args", "_handle"];
        _args params ["_flag"];

        private _flagOwner = _flag getVariable ["gradTnT_flagOwner", sideUnknown];
        ["gradTnT_points", ["flag", _flagOwner]] call CBA_fnc_serverEvent;

    }, 60, [_flag]] call CBA_fnc_addPerFrameHandler;
};