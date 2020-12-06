#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_depotDummyClasses", "_mouseClickEH"];

private _side = side player;

private _depotsBuiltID = format ["SB_depotsBuilt_%1", _side];
private _depotsBuilt = missionNameSpace getVariable [_depotsBuildID, 0];

if (_depotsBuilt >= SB_DEPOTS_MAX) exitWith {
  private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", SB_MAX_DEPOTS];
  hintSilent _string;
};

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];

private _depotObjects = [];
{

    _x params ["_classname", "_relPos", ["_dirOffset",0]];

    private _position = player getRelPos _relPos;
    private _dir = getDir _player;

    private _depotPart = _depotPartType createVehicle [0,0,0];
    _depotPart setPos _position;
    _depotPart setDir (_dir + _dirOffset);
    _depotPart enableSimulationGlobal false; 

    _depotObjects pushBackUnique _depotPart;

} forEach _depotDummyClasses;

_depotObjects params ["_depot"];
_depot setVariable ["gradTnt_depotObjects", _depotObjects, true];

// up counter
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

[_depot] remoteExec ["gradTnT_fnc_depotActionDestroy", 0, true];
[_depot] remoteExec ["gradTnT_fnc_depotMarker", 0, true];

player setVariable ["gradTnT_carryDepotDummys", []];