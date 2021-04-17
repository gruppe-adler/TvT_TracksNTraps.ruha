params ["_vehicle"];

[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (!alive _vehicle) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
    if (!(_vehicle getVariable ["gradTnT_trenchMode", false])) exitWith {};

    private _speed = velocityModelSpace _vehicle select 1;

    if (_speed > 1) then { 
        [_vehicle] call gradTnT_fnc_bpz_buildTrench_buildFX;
    };

}, 0.1, [_vehicle]] call CBA_fnc_addPerFrameHandler;