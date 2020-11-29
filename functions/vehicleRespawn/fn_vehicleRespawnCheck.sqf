params ["_vehType", "_respawnWhenNotDead", "_vehDir", "_vehPos", "_handle", "_customCode"];

if ( _veh distance _vehPos > (sizeOf _vehType)) exitWith {
  diag_log format ["grad-vehicleRespawn: too close to original position"];
};

private _positionEmpty = nearestObjects [_vehPos, ["Man", "LandVehicle", "Air"], (sizeOf _vehType)/2];

private _isRoom = count _positionEmpty isEqualTo 0;

// if position is empty
if (_isRoom) then {

    [_handle] call CBA_fnc_removePerFrameHandler;
    [_vehType, _respawnWhenNotDead, _vehPos, _vehDir, _customCode] call gradSB_fnc_vehicleRespawnSpawn;
};
