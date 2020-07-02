params ["_player", "_side"];

private _dir = getDir _player;
private _position = position player;

private _positionInFront = player getRelPos [10, 0];

private _depot = if (_side == west) then {
    [
        "gm_ge_army_shelteraceII_repair",
        "Land_RepairDepot_01_green_F",
        "land_gm_camonet_04_nato"
    ]
} else {
    [
        "gm_gc_army_shelterlakII_repair",
        "Land_RepairDepot_01_green_F",
        "land_gm_camonet_04_east"
    ]
};

// systemChat (str _depot);


_depot params ["_shelterType", "_depotType", "_camonetType"];


private _shelter = _shelterType createVehicle [0,0,0];
_shelter setPos _positionInFront;
_shelter setDir _dir;
_shelter enableSimulationGlobal false;

private _positionDepot = _shelter getRelPos [5, -90];

private _depot = _depotType createVehicle [0,0,0];
_depot setPos _positionDepot;
_depot setDir _dir;
_depot enableSimulationGlobal false;

private _positionCamoNet = _shelter getRelPos [2.5, -90];

private _camoNet = _camonetType createVehicle [0,0,0];

_camoNet allowDamage false;

_camoNet setPos _positionCamoNet;
_camoNet setDir (_dir+90);


_depot setVariable ["SB_shelter", _shelter, true];
_depot setVariable ["SB_camoNet", _camoNet, true];


// fuel
[_depot, 100000] call ace_refuel_fnc_makeSource;

// repair
_depot setVariable ["ACE_isRepairFacility", true, true];    

// rearm
if (_side == west) then {
    [_depot, "gm_ge_army_Leopard1a5"] call ace_rearm_fnc_addVehicleMagazinesToSupply;    
} else {
    [_depot, "gm_gc_army_t55am2b"] call ace_rearm_fnc_addVehicleMagazinesToSupply;
};

[_depot, 100000] call ace_rearm_fnc_setSupplyCount;

[_depot] remoteExec ["gradSB_fnc_depotAction", 0, true];