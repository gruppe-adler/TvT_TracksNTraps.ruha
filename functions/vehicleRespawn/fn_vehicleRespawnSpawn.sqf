params ["_vehtype", "_respawnWhenNotDead", "_vehPos", "_vehDir", "_customCode"];

_veh = createVehicle [ _vehtype, [0,0,0], [], 0, "NONE" ];
// _veh setVariable ["RHS_Decal_Enabled", false, true];
_veh setPos [ ( _vehPos select 0 ), ( _vehPos select 1 ), 1 ];
_veh setDir _vehDir;

[_veh, _respawnWhenNotDead] call gradSB_fnc_vehicleRespawnConfig;

if (_customCode != "") then {
  [_veh] call compile _customCode;
};
