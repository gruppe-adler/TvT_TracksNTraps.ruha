params ["_side", "_flag"];

private _addFlagSpawnMenu = [ 
    "flagTaxiMenu", 
    "Spawn Troop Transport", 
    "", 
    { 
        params ["_target", "_player", "_params"];
        _params params ["_side", "_flag"];

        [_side, _flag] remoteExec ["gradTnT_fnc_taxiSpawn", 2];
    }, 
    { 
        true
    }, 
    {}, 
    [_side, _flag], 
    [0,-0.35,-2.4],
    3, 
    [false,false,false,false,false]
] call ace_interact_menu_fnc_createAction; 
 
[_flag, 0, [], _addFlagSpawnMenu] call ace_interact_menu_fnc_addActionToObject;