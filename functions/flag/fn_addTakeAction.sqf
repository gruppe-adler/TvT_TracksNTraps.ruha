params ["_vehicle"];

if ((_vehicle isKindOf "gm_gc_army_t55am2b") || (_vehicle isKindOf "gm_ge_army_Leopard1a5")) exitWith {};

private _flagTakeAction = [
    "flagTake",
    "Take Flag",
    "\A3\ui_f\data\igui\cfg\actions\takeflag_ca.paa",
    {
        [_player] call gradTnT_flag_fnc_take;
    }, {
        isNull (_player getVariable ["gradTnT_ownerOfFlag", objNull]) && ([_target] call gradTnT_fnc_side) isEqualTo (side _player)
    },{},nil,[0,0,0],5,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _flagTakeAction] call ace_interact_menu_fnc_addActionToObject;