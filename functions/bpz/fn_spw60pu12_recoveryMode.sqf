params ["_vehicle", "_enter"];


_vehicle setVariable ["gradTnT_recoveryMode", _enter, true];

if (_enter) then {
    // enter recovery mode
    _vehicle animateSource ['antennamast_01_elev_source', 1, 4];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];
    _vehicle setVariable ["gradTnT_fuelCache", fuel _vehicle, true];
    [_vehicle, 0] remoteExec ["setFuel", _vehicle];

    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "antennamast_01_elev_source" > 0.8)
    },{
        params ["_vehicle"];

        _vehicle setVariable ["ACE_isRepairVehicle", 1, true];
        _vehicle setVariable ["gradTnT_isAnimating", false, true];
        hint "Vehicle in Recovery Mode";

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;

} else {
    // exit recovery mode
    _vehicle animateSource ['antennamast_01_elev_source', 0, 4];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];

    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "antennamast_01_elev_source" < 0.1)
    },{
        params ["_vehicle"];

        _vehicle setVariable ["ACE_isRepairVehicle", 0, true];
        _vehicle setVariable ["gradTnT_isAnimating", false, true];
        hint "Vehicle left Recovery Mode";

        private _fuel = _vehicle getVariable ["gradTnT_fuelCache", 1];
        _vehicle setFuel _fuel;
        [_vehicle, _fuel] remoteExec ["setFuel", _vehicle];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
};