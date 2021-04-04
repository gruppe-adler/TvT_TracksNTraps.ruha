params ["_player"];

private _types = ["gm_ge_army_bpz2a0"];
private _position = getPos _player;
private _possibleRepairVehicles = nearestObjects [_player, _types, 30];
private _isNear = false;

if (count _possibleRepairVehicles > 0) then {
    {
        private _repairVehicle = _x;
        if (_repairVehicle getVariable ["gradTnT_vehicleSide", sideUnknown] == side _player) then {
            if (_repairVehicle getVariable ["ACE_isRepairVehicle", false]) then {
                _isNear = true;
            } else {
                hint "You need to go into recovery mode with your BPz!";
            };
        };
    } forEach _possibleRepairVehicles;
};

_isNear