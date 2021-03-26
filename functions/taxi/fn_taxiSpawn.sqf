params ["_side", "_flag"];

private _position = getPos _flag;

if (isOnRoad _position) then {
    private _road = [_position, 20, []] call BIS_fnc_nearestRoad;
    _position = getPosATL _road;
};

private _dir = getDir _flag;
private _classname = "gm_ge_army_iltis_cargo";

if (_side == west) then {
    _classname = "gm_ge_army_iltis_cargo";
} else {
    _classname = "gm_gc_bgs_uaz469_cargo";
};

private _result = [_position, _dir, _classname, _side] call BIS_fnc_spawnVehicle;
private _vehicle = _result select 0;
private _vehiclesCrew = _result select 1;
private _vehiclesGroup = _result select 2;

clearItemCargoGlobal _vehicle;

_vehicle setVariable ["gradTnT_assignedDriver", _vehiclesCrew select 0];
_vehicle setVariable ["gradTnT_isTaxi", true, true];
_vehicle setVariable ["gradTnT_taxiSpawnPosition", _position, true];


[_vehicle] call gradTnT_fnc_addGetInHandler;

// amount gets added to enemy score and reduced when car successfully despawned again
["gradTnT_points", ["car", [_side] call gradTnT_fnc_getOpposingSide]] call CBA_fnc_serverEvent;
