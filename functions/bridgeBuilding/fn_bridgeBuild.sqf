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
private _offset = _bridgeDummy getVariable ["gradTnT_bridgeAttachPosition", [0, 16, 1.5]];
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
player setVariable ["gradTnT_carryBridge", -1];

private _side = side player;
private _varKey = format ["gradTnT_bridgesBuilt_%1", _side];
private _bridgesBuilt = missionNamespace getVariable [_varKey, 0];

// exitwith
if (_bridgesBuilt >= gradTnT_MAX_BRIDGES) exitWith {
    private _string = format ["Bridge Limit of %1 reached. Destroy one of the placed bridges via ACE Interact to be able to build new ones.", gradTnT_MAX_BRIDGES];
    hintSilent _string;
};


private _bridge = createSimpleObject ["\a3\structures_f_exp\infrastructure\bridges\bridgewooden_01_f.p3d", _position];
_bridge setPosATL _position;
_bridge setDir _dir;

[_bridge, false] remoteExec ["enableSimulationGlobal", 2];

[{
    params ["_bridge"];
    private _bridgeHelper = "DemoCharge_F" createVehicle [0,0,0];
    _bridgeHelper attachTo [_bridge,[0,0,0.97]];

    _bridgeHelper setVariable ["gradTnT_bridgeHelperBridge", _bridge, true];
    _bridge setVariable ["gradTnT_bridgeHelper", _bridgeHelper, true];

    [_bridge, _bridgeHelper] remoteExec ["gradTnT_fnc_bridgeActionDestroy", 0, true];
}, [_bridge], 2] call CBA_fnc_waitAndExecute;

_bridgesBuilt = _bridgesBuilt + 1;
missionNamespace setVariable [_varKey, _bridgesBuilt, true];

private _bridgesLeft = format ["You can build %1 more bridges.", (2 - _bridgesBuilt)];
hintSilent _bridgesLeft;

private _side = side player;
_bridge setVariable ["gradTnT_vehicleSide", _side, true];

[_bridge, "bridge"] call gradTnT_bft_fnc_add;

[_bridge, false] remoteExec ["gradTnT_fnc_bridgeMarker", _side, true];
