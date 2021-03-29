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

    private _depotDummyClasses = if (side player == west) then {
        [
            ["gm_ge_army_shelteraceII_repair", [2.5,-3],90]
        ]
    } else {
        [
            ["gm_gc_army_shelterlakII_repair", [2.5,-3],90]
        ]
    };

    /*
        ,
            ["Land_RepairDepot_01_green_F", [7, 0],-270],
            ["land_gm_camonet_04_nato", [2.5,0],0]
        
        ,
            ["Land_RepairDepot_01_green_F", [7, 0],-270],
            ["land_gm_camonet_04_east", [2.5, 0],0]
    */

    private _depotDummys = [];

    // _depotDummy setVectorDirAndUp [[1,0,0],[0,0,1]];
    {
        _x params ["_classname", "_relPos", "_offsetDir"];

        private _depotDummy =  _classname createVehicleLocal [0,0,0];
        _depotDummy enableSimulation false;
        _depotDummy disableCollisionWith player;
        private _position = [_relPos] call gradTnT_fnc_depotGetOffset;
        _depotDummy setPos _position;
        _depotDummy setDir (getDir player + _offsetDir);

        _depotDummys pushBackUnique [_depotDummy, _relPos, _offsetDir];

    } forEach _depotDummyClasses;

    diag_log format ["_depotDummyClasses %1", _depotDummyClasses];

    player setVariable ["gradTnT_carrydepot", 1];
    player setVariable ["gradTnT_carrydepotDummys", _depotDummys];

    // framehandler to setpos dummy elements, remove attachto due to complexity/not necessary
    [{
        params ["_args", "_handle"];
        _args params ["_depotDummys", "_depotDummyClasses", "_mouseClickEH"];

        {
            _x params ["_depotDummy", "_relPos", "_offsetDir"];
            private _position = [_relPos] call gradTnT_fnc_depotGetOffset;
            _depotDummy setPos _position;
            _depotDummy setDir (getDir player + _offsetDir);

            /*
            if (_forEachIndex == 0) then {
                if (!(surfaceIsWater position _depotDummy)) then {
                    {
                        (_x select 0) hideObject false;
                    } forEach _depotDummys;
                    hintSilent "CanPlace";
                } else {
                    {
                        (_x select 0) hideObject true;
                    } forEach _depotDummys;
                    hintSilent "Surface must be land";
                };
            };
            */
        } forEach _depotDummys;

        if (player getVariable ["gradTnT_carrydepot", 0] isEqualTo -1) exitWith {
              [_depotDummys, _mouseClickEH] call gradTnT_fnc_depotBuildAbort;
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if (player getVariable ["gradTnT_carrydepot", 0] isEqualTo 2) exitWith {
              [_depotDummyClasses, _depotDummys, _mouseClickEH] call gradTnT_fnc_depotBuild;
              player setVariable ["gradTnT_carrydepot", -1];
              [_handle] call CBA_fnc_removePerFrameHandler;
        };

    }, 0, [_depotDummys, _depotDummyClasses, _mouseClickEH]] call CBA_fnc_addPerFrameHandler;

}, [], 1] call CBA_fnc_waitAndExecute;
