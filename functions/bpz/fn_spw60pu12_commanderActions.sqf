["gm_gc_army_btr60pu12", "init", {
    
    params ["_vehicle"];

    _vehicle addAction
    [
        "<t color='#FF0000'>Enter Recovery Mode</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, true] call gradTnT_fnc_spw60pu12_recoveryMode;
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

            [_target, false] call gradTnT_fnc_spw60pu12_recoveryMode;
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

}, true, [], true] call CBA_fnc_addClassEventHandler;