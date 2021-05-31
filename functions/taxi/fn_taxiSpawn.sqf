params ["_side", "_flag"];

private _position = getPos _flag;
private _dir = getDir _flag;
private _classname = "gm_ge_army_iltis_cargo";

if (_side == east) then {
    _classname = "gm_gc_bgs_uaz469_cargo";
};

private _roadArray = _position nearRoads 500;
private _closestRoads = [_roadArray, [_position], { _input0 distance _x }, "ASCEND"] call BIS_fnc_sortBy;
private _emptyIndex = 0;


for "_i" from _emptyIndex to ((count _closestRoads) - 1) do {
    private _road = (_closestRoads select _i);
    private _roadDir = _dir;
    private _roadPos = getPos _road;
    private _roadsConnectedTo = roadsConnectedTo _road;
    if (count _roadsConnectedTo > 0) then {
        private _connectedRoad = _roadsConnectedTo select 0;
        _roadDir = [_road, _connectedRoad] call BIS_fnc_DirTo;
    };

    private _foundStuff = (allMissionObjects "") inAreaArray [_roadPos, 8, 8, _roadDir, true, -1];

    // systemChat str _foundStuff;

    if ((count _foundStuff) < 1) exitWith {
        private _vehiclesGroup = createGroup _side;

        private _vehicle = _classname createVehicle [0,0,0]; // create elsewhere so you dont see the rotation glitch
        _vehicle setDir _dir;
        _roadPos set [2,0.6]; // elevate a bit in case of bumps in the road or other shit instaploding

        _vehicle setPos _roadPos;
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
        
    };
};