/*
execVM "functions\fn_bridgeBuild.sqf";
*/

#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

params ["_bridgeDummy", "_mouseClickEH", "_mouseWheelEH"];

private _position = getPosATLVisual _bridgeDummy;
_position params ["_posX", "_posY", "_posZ"];
private _dir = getDir player;

/*
private _offset = _bridgeDummy getVariable ["gradSB_bridgeAttachPosition", [0, 16, 1.5]];
_offset params ["_offsetX", "_offsetY", "_offsetZ"];
_position set [2,(_posZ + _offsetZ)];
*/

deleteVehicle _bridgeDummy;
addCamShake [10, 1, 3];

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseClickEH];
(findDisplay 46) displayRemoveEventHandler ["MouseZChanged", _mouseWheelEH];

[] call EFUNC(interaction,hideMouseHint);

inGameUISetEventHandler ["PrevAction", "false"];
inGameUISetEventHandler ["NextAction", "false"];

player forceWalk false;
player setVariable ["gradSB_carryBridge", objNull];

private _bridgesBuild = _unit getVariable ["SB_bridgesBuilt", 0];
// exitwith
if (_bridgesBuild >= SB_MAX_BRIDGES) exitWith {
    private _string = format ["Bridge Limit of %1 reached. Destroy one of the placed bridges via ACE Interact to be able to build new ones.", SB_MAX_BRIDGES];
    hintSilent _string;
};

private _bridge = createVehicle ["CUP_A2_Road_Bridge_wood_25", _position, [], 0, "CAN_COLLIDE"];
_bridge setPosATL _position;
_bridge setDir (_dir + 90);

_bridge enableSimulationGlobal false;

private _bridgeHelper = "rhs_ec400" createVehicleLocal [0,0,0];
_bridgeHelper attachTo [_bridge,[2,0,2.5]];

_bridgeHelper setVariable ["gradSB_bridgeHelperBridge", _bridge, true];
_bridge setVariable ["gradSB_bridgeHelper", _bridgeHelper, true];

private _bridgesBuild = _unit getVariable ["SB_bridgesBuilt", 0];
_bridgesBuild = _bridgesBuild + 1;
player setVariable ["SB_bridgesBuilt", _bridgesBuild, true];

[_bridge] remoteExec ["gradSB_fnc_bridgeActionDestroy", 0, true];
[_bridge, side player] remoteExec ["gradSB_fnc_bridgeMarker", 0, true];
