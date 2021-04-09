params ["_side", "_flag"];

private _position = getPos _flag;

private _road = [_position, 100, []] call BIS_fnc_nearestRoad;
_position = getPosATL _road;

private _dir = getDir _flag;
private _classname = "gm_ge_army_iltis_cargo";

if (_side == east) then {
    _classname = "gm_gc_bgs_uaz469_cargo";
};

private _vehiclesGroup = createGroup _side;
private _vehicle = createVehicle [_classname, _position, [], 60, "none"];
_vehicle setDir _dir;
createVehicleCrew _vehicle;

private _vehiclesCrew = crew _vehicle;
_vehiclesCrew joinsilent _vehiclesGroup;
_vehiclesGroup addVehicle _vehicle;

clearBackpackCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

_vehicle lockDriver true;

_vehicle setVariable ["gradTnT_assignedDriver", _vehiclesCrew select 0];
_vehicle setVariable ["gradTnT_isTaxi", true, true];
_vehicle setVariable ["gradTnT_taxiSpawnPosition", _position, true];


[_vehicle] call gradTnT_fnc_addGetInHandler;

// amount gets added to enemy score and reduced when car successfully despawned again
["gradTnT_points", ["car", [_side] call gradTnT_fnc_getOpposingSide]] call CBA_fnc_serverEvent;
