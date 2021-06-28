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
}, "Attaching Explosive (20s Countdown - then respawn)", {
    params ["_args"];
    _args params ["_vehicle"];

    if ([_vehicle, ACE_player] call ace_interaction_fnc_getInteractionDistance > 4) then {
        false
    } else {
        true
    };

}] call ace_common_fnc_progressBar;


[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (!(_vehicle getVariable ["gradTnT_explosiveAttaching", false])) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _sound = selectRandom ["bongs1", "bongs2", "bongs3", "bongs4"];
    {
        if (alive _x && objectParent _x == _vehicle) then {
            [_sound] remoteExec ["playSound", _x];
            ["Something scratches on your tank..."] remoteExec ["hintSilent", _x];
        };
    } forEach crew _vehicle;

}, 2, [_vehicle]] call CBA_fnc_addPerFrameHandler;