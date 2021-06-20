#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

["Build Bridge","",""] call EFUNC(interaction,showMouseHint);
[player] call ace_weaponselect_fnc_putWeaponAway;
player forceWalk true;

[{

    private _mouseClickEH = (findDisplay 46) displayAddEventHandler [
        "MouseButtonDown",
        "_this call gradTnT_fnc_bridgeMouseClick"
    ];
    /*
    private _mouseWheelEH = (findDisplay 46) displayAddEventHandler [
        "MouseZChanged",
        "_this call gradTnT_fnc_bridgeMouseWheel"
    ];
    */

    inGameUISetEventHandler ["PrevAction", "true"];
    inGameUISetEventHandler ["NextAction", "true"];

    private _carryAttachX = 0;
    private _carryAttachY = 16;
    private _carryAttachH = 0;

    private _bridgeDummy = createSimpleObject ["\a3\structures_f_exp\infrastructure\bridges\bridgewooden_01_f.p3d", [0,0,0], true];
    _bridgeDummy setVariable ["gradTnT_bridgeAttachPosition", [_carryAttachX, _carryAttachY, _carryAttachH]];
    _bridgeDummy attachTo [player,[_carryAttachX, _carryAttachY, _carryAttachH]];
    // _bridgeDummy setVectorDirAndUp [[1,0,0],[0,0,1]];

    player setVariable ["gradTnT_carryBridge", 1];
    player setVariable ["gradTnT_carryBridgeDummy", _bridgeDummy];

    [{
        params ["_args", "_handle"];
        _args params ["_bridgeDummy", "_mouseClickEH"];

        if (surfaceIsWater position _bridgeDummy) then {
            _bridgeDummy hideObject false;
        } else {
            _bridgeDummy hideObject true;
            hintSilent "Surface must be water";
        };

        private _offset = _bridgeDummy getVariable ["gradTnT_bridgeAttachPosition", [0, 16, 0]];
        _offset params ["_carryAttachX", "_carryAttachY", "_carryAttachH"];

        private _zOffset = ((AGLtoASL (player modelToWorld [0,0,0])) select 2) + 0.5; // make bridge flat on water

        _bridgeDummy attachTo [player, [_carryAttachX, _carryAttachY, -_zOffset]];
        _bridgeDummy setVariable ["gradTnT_bridgeAttachPosition", _attachPosition];

        if (player getVariable ["gradTnT_carryBridge", 0] isEqualTo 2) exitWith {
              [_bridgeDummy, _mouseClickEH] call gradTnT_fnc_bridgeBuild;
              player setVariable ["gradTnT_carryBridge", -1];
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if (player getVariable ["gradTnT_carryBridge", 0] isEqualTo -1) exitWith {
              [_bridgeDummy, _mouseClickEH] call gradTnT_fnc_bridgeBuildAbort;
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

    }, 0 , [_bridgeDummy, _mouseClickEH]] call CBA_fnc_addPerFrameHandler;

}, [], 1] call CBA_fnc_waitAndExecute;