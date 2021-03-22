["gm_ge_army_bpz2a0", "init", {
    
    params ["_vehicle"];

    _vehicle addAction
    [
        "Enter Recovery Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, true] call gradTnT_fnc_bpz_recoveryMode;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "_this in (crew (_target)) && speed (_target) < 1 && !(_target getVariable ['recoveryMode', false])",
        50,
        false
    ];

    _vehicle addAction
    [
        "Exit Recovery Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, false] call gradTnT_fnc_bpz_recoveryMode;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "_this in (crew (_target)) && speed (_target) < 1 && (_target getVariable ['recoveryMode', false]) && isNull (_target getVariable ['gradTnT_bpz_vehicleHooked', objNull])",
        50,
        false
    ];



    _vehicle addAction
    [
        "Extend Rope",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, true] call gradTnT_fnc_bpz_ropeUnwind;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "_this in (crew (_target)) && speed (_target) < 1 && (_target getVariable ['recoveryMode', false])",
        50,
        false
    ];

    _vehicle addAction
    [
        "Retract Rope",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, false] call gradTnT_fnc_bpz_ropeUnwind;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "_this in (crew (_target)) && speed (_target) < 1 && (_target getVariable ['recoveryMode', false])",
        50,
        false
    ];

}] call CBA_fnc_addClassEventHandler;