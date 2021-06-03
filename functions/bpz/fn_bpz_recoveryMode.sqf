params ["_vehicle", "_enter"];


_vehicle setVariable ["gradTnT_recoveryMode", _enter, true];

if (_enter) then {
    // enter recovery mode
    _vehicle animateSource ["crane_elev_source", 0.75];
    // _vehicle animateSource ["crane_hook_unhide", 0];
    _vehicle animateSource ["dozer_blade_elev_source", 1];
    _vehicle animateSource ["crane_trav_source", 1];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];

    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "crane_elev_source" > 0.8)
    },{
        params ["_vehicle"];
        
        // [_vehicle] call gradTnT_fnc_bpz_prepareRopesCrane;
        _vehicle setVariable ["gradTnT_isAnimating", false, true];
        _vehicle setVariable ["ACE_isRepairVehicle", 1, true];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
} else {
    // exit recovery mode
    _vehicle animateSource ["crane_trav_source", 0.1];
    _vehicle animateSource ["crane_elev_source", 0];
    _vehicle animateSource ["dozer_blade_elev_source", 0];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];
    
    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "crane_trav_source" < 0.2)
    },{
        params ["_vehicle"];
        
         _vehicle setVariable ["gradTnT_isAnimating", false, true];
        // _vehicle animateSource ["crane_hook_unhide", 1];
        // [_vehicle] call gradTnT_fnc_bpz_removeRopesCrane;

        _vehicle setVariable ["ACE_isRepairVehicle", 0, true];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
};