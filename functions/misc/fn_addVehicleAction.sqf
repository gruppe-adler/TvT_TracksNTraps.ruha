params ["_vehicle"];

private _changeGroupId = [
    "changeGroupId",
    "Change Vehicle ID",
    "",
    {
        [_target] call gradTnT_fnc_bftChangeGroupId;
    }, {
          private _side = [_vehicle, true] call BIS_fnc_objectSide;
          side _target == side _player
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _changeGroupId] call ace_interact_menu_fnc_addActionToObject;