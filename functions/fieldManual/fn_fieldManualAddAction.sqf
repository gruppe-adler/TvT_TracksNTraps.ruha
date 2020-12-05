params ["_title", "_array"];

private _openManual = [
    "OpenHelp",
    _title,
    "pics\note.paa",
    {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_array"];
        _array params ["_cat1", "_cat2"];
        [_cat1, _cat2, findDisplay 46] spawn BIS_fnc_openFieldManual;
    }, {
          true
    },{},[_array],"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions"], _openManual] call ace_interact_menu_fnc_addActionToObject;
