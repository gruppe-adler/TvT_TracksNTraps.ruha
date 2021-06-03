["gm_gc_army_btr60pu12", "init", {
    
    params ["_vehicle"];

    _vehicle addAction
    [
        "Enter Recovery Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, true] call gradTnT_fnc_spw60pu12_recoveryMode;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "
            _this in (crew (_target)) && speed (_target) < 1 && 
            !(_target getVariable ['gradTnT_recoveryMode', false]) &&
            !(_target getVariable ['gradTnT_trenchMode', false])
        ",
        50,
        false
    ];

    _vehicle addAction
    [
        "Exit Recovery Mode",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target, false] call gradTnT_fnc_spw60pu12_recoveryMode;
        },
        nil,
        1.5,
        true,
        true,
        "",
        "   
            _this in (crew (_target)) && speed (_target) < 1 && 
            (_target getVariable ['gradTnT_recoveryMode', false]) && 
            isNull (_target getVariable ['gradTnT_bpz_vehicleHooked', objNull])
        ",
        50,
        false
    ];

}] call CBA_fnc_addClassEventHandler;