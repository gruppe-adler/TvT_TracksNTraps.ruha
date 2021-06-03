["gm_ge_army_bpz2a0", "init", {
    
    params ["_vehicle"];

    // [_vehicle] call gradTnT_fnc_bpz_buildTrench;

    _vehicle addAction
    [
        "<t color='#FF0000'>Enter Recovery Mode</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, true] call gradTnT_fnc_bpz_recoveryMode;
        },
        nil,
        7,
        true,
        true,
        "",
        "
            _this in (crew (_target)) && speed (_target) < 1 && 
            !(_target getVariable ['gradTnT_recoveryMode', false]) &&
            !(_target getVariable ['gradTnT_trenchMode', false]) &&
            !(_target getVariable ['gradTnT_isAnimating', false])
        ",
        50,
        false
    ];

    _vehicle addAction
    [
         "<t color='#FF0000'>Exit Recovery Mode</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, false] call gradTnT_fnc_bpz_recoveryMode;
        },
        nil,
        7,
        true,
        true,
        "",
        "   
            _this in (crew (_target)) && speed (_target) < 1 && 
            (_target getVariable ['gradTnT_recoveryMode', false]) && 
            isNull (_target getVariable ['gradTnT_bpz_vehicleHooked', objNull]) &&
            !(_target getVariable ['gradTnT_isAnimating', false])
        ",
        50,
        false
    ];

    // [_vehicle] call gradTnT_fnc_bpz_buildTrench_pfhLocal;

    /*
    _vehicle addAction
    [
        "Enter Trench Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            _target setVariable ["gradTnT_trenchMode", true, true];
            _target animateSource ["dozer_blade_elev_source", 0.65];
        },
        nil,
        1.5,
        true,
        true,
        "",
        "
          _this in (crew (_target)) && speed (_target) < 1 && 
          !(_target getVariable ['gradTnT_trenchMode', false]) &&
          !(_target getVariable ['gradTnT_recoveryMode', false])
        ",
        50,
        false
    ];

    _vehicle addAction
    [
        "Exit Trench Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target] call gradTnT_fnc_dropBuildUp;
            _target setVariable ["gradTnT_trenchMode", false, true];
            _target animateSource ["dozer_blade_elev_source", 0];
        },
        nil,
        1.5,
        true,
        true,
        "",
        "
          _this in (crew (_target)) && speed (_target) < 1 && 
          (_target getVariable ['gradTnT_trenchMode', false])
        ",
        50,
        false
    ];
    */


    /*
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
    */

}, true, [], true] call CBA_fnc_addClassEventHandler;