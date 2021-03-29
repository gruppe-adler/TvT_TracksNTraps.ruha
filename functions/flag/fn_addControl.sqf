params ["_flag", "_flagSpeakers"];

private _flagRaiseAction = [
    "flagRaise",
    "Raise Flag",
    "\A3\ui_f\data\igui\cfg\actions\take_ca.paa",
    {
        [_target, _player] remoteExec ["gradTnT_flag_fnc_raise", 2];
    }, {
        ([_target] call gradTnT_flag_fnc_canRaise)
    },{},nil,[0,-0.35,-2.4],3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_flag, 0, [], _flagRaiseAction] call ace_interact_menu_fnc_addActionToObject;



private _flagRaiseActionHint = [
    "flagRaiseHint",
    "Raise Flag (you need a flag!)",
    "\A3\ui_f\data\igui\cfg\actions\take_ca.paa",
    {
        hint "Take a flag from your engineers vehicle first!";
    }, {
        !([_target] call gradTnT_flag_fnc_canRaise)
    },{},nil,[0,-0.35,-2.4],3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_flag, 0, [], _flagRaiseActionHint] call ace_interact_menu_fnc_addActionToObject;


if (isServer) then {
    _flag setFlagTexture "";
    _flag setVariable ["gradTnT_flagSpeakers", _flagSpeakers, true];

    missionNamespace setVariable ["gradTnT_flagObjective", _flag, true];

    // count points
    [{
        params ["_args", "_handle"];
        _args params ["_flag"];

        private _flagOwner = _flag getVariable ["gradTnT_flagOwner", sideUnknown];
        ["gradTnT_points", ["flagTick", _flagOwner]] call CBA_fnc_serverEvent;

    }, 60, [_flag]] call CBA_fnc_addPerFrameHandler;
};