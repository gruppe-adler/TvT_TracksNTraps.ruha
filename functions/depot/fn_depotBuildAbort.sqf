#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_depotDummy", "_mouseClickEH"];

private _position = getPosATLVisual _depotDummy;
_position params ["_posX", "_posY", "_posZ"];
private _dir = getDir player;

player setVariable ["gradTnT_carryDepotDummys", []];
deleteVehicle _depotDummy;
addCamShake [10, 1, 3];

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];
(findDisplay 46) displayRemoveEventHandler ["MouseZChanged", _mouseWheelEH];

[] call EFUNC(interaction,hideMouseHint);

inGameUISetEventHandler ["PrevAction", "false"];
inGameUISetEventHandler ["NextAction", "false"];

player forceWalk false;
player setVariable ["gradTnT_carryDepot", -1];

private _depotsBuiltID = format ["SB_depotsBuilt_%1", side player];
private _depotsBuilt = missionNameSpace getVariable [_depotsBuildID, 0];

private _DepotsLeft = format ["Building aborted. You can build %1 more Depots.", (SB_DEPOTS_MAX - _DepotsBuilt)];
hintSilent _DepotsLeft;