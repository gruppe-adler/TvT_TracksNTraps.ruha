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
        "gm_ge_army_shelteraceII_repair",
        "Land_RepairDepot_01_green_F",
        "land_gm_camonet_04_nato"
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

private _destroyAction = [
    "RepairHole",
    "Destroy Depot",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        [_target] execVM "functions\fn_destroyDepot.sqf";
    }, {
        !(_target getVariable ["SB_depotDestroyed", false])
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_depot, 0, ["ACE_MainActions"], _destroyAction] call ace_interact_menu_fnc_addActionToObject;