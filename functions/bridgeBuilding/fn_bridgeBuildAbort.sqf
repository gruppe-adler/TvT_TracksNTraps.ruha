#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_bridgeDummy", "_mouseClickEH"];

private _position = getPosATLVisual _bridgeDummy;
_position params ["_posX", "_posY", "_posZ"];
private _dir = getDir player;

player setVariable ["gradTnT_carryBridgeDummy", objNull];
deleteVehicle _bridgeDummy;
addCamShake [10, 1, 3];

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];
// (findDisplay 46) displayRemoveEventHandler ["MouseZChanged", _mouseWheelEH];

[] call EFUNC(interaction,hideMouseHint);

inGameUISetEventHandler ["PrevAction", "false"];
inGameUISetEventHandler ["NextAction", "false"];

player forceWalk false;
player setVariable ["gradTnT_carryBridge", -1];

private _side = side player;
private _varKey = format ["gradTnT_bridgesBuilt_%1", _side];
private _bridgesBuilt = missionNamespace getVariable [_varKey, 0];

private _bridgesLeft = format ["Building aborted. You can build %1 more bridges.", (SB_BRIDGES_MAX - _bridgesBuilt)];
hintSilent _bridgesLeft;