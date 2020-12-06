#include "\z\ace\addons\main\script_component.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

["Build Depot","",""] call EFUNC(interaction,showMouseHint);
[player] call ace_weaponselect_fnc_putWeaponAway;
player forceWalk true;

[{

    private _mouseClickEH = (findDisplay 46) displayAddEventHandler [
        "MouseButtonDown",
        "_this call gradTnT_fnc_depotMouseClick"
    ];

    inGameUISetEventHandler ["PrevAction", "true"];
    inGameUISetEventHandler ["NextAction", "true"];

    private _carryAttachX = 0;
    private _carryAttachY = 16;
    private _carryAttachH = 0;

    private _depotDummyClasses = if (_side == west) then {
        [
            ["gm_ge_army_shelteraceII_repair", [10,0],0],
            ["Land_RepairDepot_01_green_F", [5, -90],0],
            ["land_gm_camonet_04_nato", [2.5,-90],90]
        ]
    } else {
        [
            ["gm_gc_army_shelterlakII_repair", [10,0],0],
            ["Land_RepairDepot_01_green_F", [5, -90],0],
            ["land_gm_camonet_04_east", [2.5, -90],90]
        ]
    };

    private _depotDummys = [];

    // _depotDummy setVectorDirAndUp [[1,0,0],[0,0,1]];
    {
        _x params ["_classname", "_relPos", "_offsetDir"];
        private _depotDummy = createSimpleObject [_classname, [0,0,0], true];
        private _offset = [_depotDummy, _relPos] call gradTnT_fnc_depotGetOffset;
        _depotDummys pushBackUnique [_depotDummy, _relPos];
        _depotDummy attachTo [player, _offset];

    } forEach _depotDummyClasses;

    player setVariable ["gradTnT_carrydepot", 1];
    player setVariable ["gradTnT_carrydepotDummy", _depotDummys];

    [{
        params ["_args", "_handle"];
        _args params ["_depotDummys", "_mouseClickEH"];

        {
            _x params ["_depotDummy", "_depotDummyClasses", "_relPos"];
            private _offset = [_depotDummy, _relPos] call gradTnT_fnc_depotGetOffset;
            _depotDummy attachTo [player, _offset]; 

            if (_forEachIndex == 0) then {
                if (!(surfaceIsWater position _depotDummy)) then {
                    {
                        _x hideObject false;
                    } forEach _depotDummys;
                } else {
                    {
                        _x hideObject true;
                    } forEach _depotDummys;
                    hintSilent "Surface must be land";
                };
            };
        } forEach _depotDummys;

        if (player getVariable ["gradTnT_carrydepot", 0] isEqualTo 2) exitWith {
              [_depotDummyClasses, _mouseClickEH] call gradTnT_fnc_depotBuild;
              player setVariable ["gradTnT_carrydepot", -1];
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if (player getVariable ["gradTnT_carrydepot", 0] isEqualTo -1) exitWith {
              [_depotDummyClasses, _mouseClickEH] call gradTnT_fnc_depotBuildAbort;
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

    },1, [_depotDummys, _depotDummyClasses, _mouseClickEH]] call CBA_fnc_addPerFrameHandler;

}, [], 1] call CBA_fnc_waitAndExecute;