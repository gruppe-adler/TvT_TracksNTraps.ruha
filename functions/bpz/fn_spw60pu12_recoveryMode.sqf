params ["_vehicle", "_enter"];


_vehicle setVariable ["gradTnT_recoveryMode", _enter, true];

if (_enter) then {
    // enter recovery mode
    _vehicle animateSource ['antennamast_01_elev_source', 1];

    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "antennamast_01_elev_source" > 0.5)
    },{
        params ["_vehicle"];

        _vehicle setVariable ["ACE_isRepairVehicle", 1, true];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
} else {
    // exit recovery mode
    _vehicle animateSource ['antennamast_01_elev_source', 0];

    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "antennamast_01_elev_source" < 0.5)
    },{
        params ["_vehicle"];

        _vehicle setVariable ["ACE_isRepairVehicle", 0, true];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
};