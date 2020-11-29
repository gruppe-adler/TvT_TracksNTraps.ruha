player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];

    _unit setVariable ["gradSB_lastVehicleUsed", _vehicle, true];
}];