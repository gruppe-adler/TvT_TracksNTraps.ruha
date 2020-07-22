#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

["Build Bridge","",""] call EFUNC(interaction,showMouseHint);
[player] call ace_weaponselect_fnc_putWeaponAway;
player forceWalk true;
sleep 1;

private _mouseClickEH = (findDisplay 46) displayAddEventHandler [
    "MouseButtonDown",
    "_this call gradSB_fnc_bridgeMouseClick"
];
private _mouseWheelEH = (findDisplay 46) displayAddEventHandler [
    "MouseZChanged",
    "_this call gradSB_fnc_bridgeMouseWheel"
];

inGameUISetEventHandler ["PrevAction", "true"];
inGameUISetEventHandler ["NextAction", "true"];

private _carryAttachX = 0;
private _carryAttachY = 16;
private _carryAttachH = 1.5;

private _bridgeDummy = "CUP_A2_Road_Bridge_wood_25" createVehicleLocal [0,0,0];
_bridgeDummy setVariable ["gradSB_bridgeAttachPosition", [_carryAttachX, _carryAttachY, _carryAttachH]];
_bridgeDummy attachTo [player,[_carryAttachX, _carryAttachY, _carryAttachH]];
_bridgeDummy setVectorDirAndUp [[1,0,0],[0,0,1]];

player setVariable ["gradSB_carryBridge", _bridgeDummy];

[{
    params ["_args", "_handle"];
    _args params ["_bridgeDummy", "_mouseClickEH", "_mouseWheelEH"];

    if (surfaceIsWater position _bridgeDummy) then {
        _bridgeDummy hideObject false;
    } else {
        _bridgeDummy hideObject true;
        hintSilent "Surface must be water";
    };

    if (isNull (player getVariable ["gradSB_carryBridge", objNull])) exitWith {
          [_handle] call CBA_fnc_removePerFrameHandler;
          [_bridgeDummy, _mouseClickEH, _mouseWheelEH] call gradSB_fnc_bridgeBuild;
    };

},1, [_bridgeDummy, _mouseClickEH, _mouseWheelEH]] call CBA_fnc_addPerFrameHandler;
