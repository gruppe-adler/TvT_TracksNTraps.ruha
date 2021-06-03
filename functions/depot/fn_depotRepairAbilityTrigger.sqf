params ["_depot"];

private _trigger = createTrigger ["EmptyDetector", getPos _depot, false];
_trigger setTriggerArea [30, 30, 30, false];

[{
    params ["_args", "_handle"];
    _args ["_depot", "_trigger"];

    {
        private _player = _x;

        // dont manage native engineers
        if (!(_x getVariable ["gradTnT_isEngineer", false])) then {
            if (_x inArea _trigger) then {
                    _x setVariable ["ACE_isEngineer", 2, true];
            } else {
                // dont broadcast to player if not necessary
                if (_x getVariable ["ACE_isEngineer", 0] > 0) then {
                    _x setVariable ["ACE_isEngineer", 0, true];
                };
            };
        };
    } forEach allPlayers;


    if (_depot getVariable ["gradTnT_depotDestroyed", false]) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
    
}, 3, [_depot, _trigger]] call CBA_fnc_addPerFrameHandler;

_trigger