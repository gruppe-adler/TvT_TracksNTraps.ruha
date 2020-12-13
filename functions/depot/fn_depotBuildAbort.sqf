#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_depotDummys", "_mouseClickEH"];

{
  deleteVehicle (_x select 0);
} forEach _depotDummys;
player setVariable ["gradTnT_carryDepotDummys", []];

addCamShake [10, 1, 3];

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];

[] call EFUNC(interaction,hideMouseHint);

inGameUISetEventHandler ["PrevAction", "false"];
inGameUISetEventHandler ["NextAction", "false"];

player forceWalk false;
player setVariable ["gradTnT_carryDepot", -1];

private _depotsBuiltID = format ["gradTnT_depotsBuilt_%1", side player]; 
private _depotsBuilt = missionNameSpace getVariable [_depotsBuiltID, 0];

private _depotsLeft = format ["Building aborted. You can build %1 more Depots.", (gradTnT_DEPOTS_MAX - _depotsBuilt)];
hintSilent _depotsLeft;