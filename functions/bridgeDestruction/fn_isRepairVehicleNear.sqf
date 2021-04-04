params ["_player"];

private _types = ["gm_ge_army_bpz2a0"];

private _position = getPos _player;
private _possibleRepairVehicles = nearestObjects [_player, _types, 30];
private _isNear = false;

if (count _possibleRepairVehicles > 0) then {
    {
        if (_x getVariable ["gradTnT_vehicleSide"] == side _player) exitWith {
            _isNear = true;
        };
    } forEach _possibleRepairVehicles;
};

_isNear