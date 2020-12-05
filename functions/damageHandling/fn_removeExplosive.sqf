params ["_vehicle"];

[3, [_vehicle], {
    params ["_args"];
    _args params ["_vehicle"];

    if (_vehicle getVariable ["gradTnT_explosiveAttached", false]) then {
        _vehicle setVariable ["gradTnT_explosiveAttached", false, true];
        hint "Explosive removed";
    };
}, {
    params ["_args"];
    _args params ["_vehicle"];
    hint "Aborted!";
}, "Removing Explosive"] call ace_common_fnc_progressBar;