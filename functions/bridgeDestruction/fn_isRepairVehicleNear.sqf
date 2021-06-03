params ["_player"];

private _position = getPos _player;
private _possibleRepairVehicles = nearestObjects [_player, ["LandVehicle", "gm_container_base"], 30];
private _isNear = false;

if (count _possibleRepairVehicles > 0) then {
    {
        private _repairVehicle = _x;
        if (_repairVehicle getVariable ["gradTnT_isEngineerVehicle", false] && _repairVehicle getVariable ["gradTnT_vehicleSide", sideUnknown] == side _player) then {
            if (_repairVehicle getVariable ["ACE_isRepairVehicle", 0] == 1) then {
                _isNear = true;
            } else {
                hint "You need to go into recovery mode with your Engineer Vehicle!";
            };
        };
    } forEach _possibleRepairVehicles;
} else {
    hint "No Engineer Vehicle in close range";
};

_isNear