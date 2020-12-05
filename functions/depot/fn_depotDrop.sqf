params ["_player", "_side"];

private _depotsBuiltID = format ["SB_depotsBuilt_%1", _side];
private _depotsBuilt = missionNameSpace getVariable [_depotsBuildID, 0];

if (_depotsBuilt >= SB_DEPOTS_MAX) exitWith {
  private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", SB_MAX_DEPOTS];
  hintSilent _string;
};

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


_depot setVariable ["gradTnT_shelter", _shelter, true];
_depot setVariable ["gradTnT_camoNet", _camoNet, true];

_depotsBuild = _depotsBuild + 1;
missionNameSpace setVariable [_depotsBuildID, _depotsBuilt, true];

// fuel
[_depot, 100000] call ace_refuel_fnc_makeSource;

// repair
_depot setVariable ["ACE_isRepairFacility", true, true];
_depot setVariable ["gradTnT_depotSide", _side, true];

// rearm
if (_side == west) then {
    [_depot, "gm_ge_army_Leopard1a5"] call ace_rearm_fnc_addVehicleMagazinesToSupply;
} else {
    [_depot, "gm_gc_army_t55am2b"] call ace_rearm_fnc_addVehicleMagazinesToSupply;
};

[_depot, 100000] call ace_rearm_fnc_setSupplyCount;

[_depot] remoteExec ["gradTnT_fnc_depotAction", 0, true];
[_depot] remoteExec ["gradTnT_fnc_depotMarker", 0, true];
