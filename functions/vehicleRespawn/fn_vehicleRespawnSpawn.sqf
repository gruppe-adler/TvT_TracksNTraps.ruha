params ["_vehtype", "_respawnWhenNotDead", "_vehPos", "_vehDir", "_customCode", "_gmAttributes"];

_veh = createVehicle [ _vehtype, [0,0,0], [], 0, "NONE" ];
// _veh setVariable ["RHS_Decal_Enabled", false, true];
_veh setPos [ ( _vehPos select 0 ), ( _vehPos select 1 ), 1 ];
_veh setDir _vehDir;

[_veh, _respawnWhenNotDead, _gmAttributes] call gradSB_fnc_vehicleRespawnConfig;

if (_customCode != "") then {
  [_veh] call compile _customCode;
};

private _rootClasses = [
    ["gm_tracked_Tank_base", "tank"],
    ["gm_wheeled_APC_base", "apc"],
    ["gm_wheeled_truck_base", "car"],
    ["gm_helicopter_base", "heli"],
    ["Man","crew"]
];

private _rootClass = "";

{
    _x params ["_class", "_string"];
    if (_veh isKindOf _class) exitWith {
        _rootClass = _string;
    };
} forEach _rootClasses;

// give points to opposing side of respawning vehicle
private _side = [_veh, true] call BIS_fnc_objectSide;
private _sidePointsAddedTo = sideUnknown;
switch (_side) do { 
    case west : {  _sidePointsAddedTo = east; }; 
    case east : {  _sidePointsAddedTo = west; }; 
    default {}; 
};
["gradSB_points", [_rootClass, _sidePointsAddedTo]] call CBA_fnc_serverEvent;
