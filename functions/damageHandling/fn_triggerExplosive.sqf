params ["_vehicle"];

_vehicle setVariable ["gradTnT_explosiveAttaching", true, true];

[15, [_vehicle], {
    params ["_args"];
    _args params ["_vehicle"];

    _vehicle setVariable ["gradTnT_explosiveAttaching", false, true];
    _vehicle setVariable ["gradTnT_explosiveAttached", true, true];
    hint "Explosion in 20s";

    [{
        params ["_vehicle"];
        if (_vehicle getVariable ["gradTnT_explosiveAttached", false]) then {
            _vehicle setDamage [1, true];
        };
    }, [_vehicle], 20] call CBA_fnc_waitAndExecute;
}, {
    params ["_args"];
    _args params ["_vehicle"];
    hint "Aborted!";

    _vehicle setVariable ["gradTnT_explosiveAttaching", false, true];
}, "Attaching Explosive"] call ace_common_fnc_progressBar;

{
   ["Something cratches on your tank..."] remoteExec ["hintSilent", _x];
} forEach crew _vehicle;

[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (!(_vehicle getVariable ["gradTnT_explosiveAttaching", false])) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _sound = selectRandom ["bongs1", "bongs2", "bongs3", "bongs4"];
    {
       [_sound] remoteExec ["playSound", _x];
    } forEach crew _vehicle;

    playSound _sound;
}, 2, [_vehicle]] call CBA_fnc_addPerFrameHandler;