params ["_flag"];


private _flagRaiseAction = [
    "flagRaise",
    "Raise Flag",
    "\A3\ui_f\data\igui\cfg\actions\take_ca.paa",
    {
        [_target, _player] remoteExec ["gradSB_fnc_flagRaise", 2];
    }, {
        ([_target] call gradSB_fnc_flagCanRaise)
    },{},nil,[0,-0.35,-2.4],3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_flag, 0, [], _flagRaiseAction] call ace_interact_menu_fnc_addActionToObject;