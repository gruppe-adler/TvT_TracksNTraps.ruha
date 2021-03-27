#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_depotDummyClasses", "_depotDummys", "_mouseClickEH"];

diag_log format ["_depotDummyClasses Build %1", _depotDummyClasses];
/*

14:28:10 "_depotDummyClasses Build [
    [""gm_ge_army_shelteraceII_repair"",[10,0],0],
    [""Land_RepairDepot_01_green_F"",[5,-90],0],
    [""land_gm_camonet_04_nato"",[2.5,-90],90]]"

*/

{
  deleteVehicle (_x select 0);
} forEach _depotDummys;

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];

[] call EFUNC(interaction,hideMouseHint);
inGameUISetEventHandler ["PrevAction", "false"];
inGameUISetEventHandler ["NextAction", "false"];

player forceWalk false;
player setVariable ["gradTnT_carryDepot", -1];

private _side = side player;
private _depotsBuiltID = format ["gradTnT_depotsBuilt_%1", _side];
private _depotsBuilt = missionNameSpace getVariable [_depotsBuiltID, 0];

if (_depotsBuilt >= gradTnT_DEPOTS_MAX) exitWith {
  private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", gradTnT_MAX_DEPOTS];
  hintSilent _string;
};

hintSilent "building depot";


private _depotObjects = [];
{
    _x params ["_classname", "_relPos", "_offsetDir"];

    private _depotPart = _classname createVehicle [0,0,0];
    private _position = [_relPos] call gradTnT_fnc_depotGetOffset;
    _depotPart enableSimulationGlobal false;
    _depotPart setDir (getDir player + _offsetDir);
    _depotPart setPos _position;
    
    _depotObjects pushBackUnique _depotPart;

} forEach _depotDummyClasses;

private _depot = _depotObjects select 0;

private _depotHelper = "DemoCharge_F" createVehicle [0,0,0];
_depotHelper attachTo [_depot,[1,0,1]];
detach _depotHelper; // because setvectordirandup refuses to work otherwise
_depotHelper setVectorDirAndUp [[1,0,0], [0,0,1]];



_depotHelper setVariable ["gradTnT_depotHelperDepot", _depot, true];
_depot setVariable ["gradTnT_depotHelper", _depotHelper, true];

_depot setVariable ["gradTnt_depotObjects", _depotObjects, true];

// up counter
_depotsBuilt = _depotsBuilt + 1;
missionNameSpace setVariable [_depotsBuiltID, _depotsBuilt, true];

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

[_side, _depot, "Depot", true] remoteExec ["gradTnT_fnc_depotAddRespawn", 2];

[_depot, 100000] call ace_rearm_fnc_setSupplyCount;

[_depot] remoteExec ["gradTnT_fnc_depotActionDestroy", 0, true];

_depot setVariable ["gradTnT_vehicleSide", _side, true];

[_depot, "depot"] spawn gradTnT_bft_fnc_add;

player setVariable ["gradTnT_carryDepotDummys", []];
