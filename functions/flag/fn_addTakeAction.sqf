/*
 * Name: gradTnT_flag_fnc_addTakeAction
 * Author: nomisum
 * Add "Take Flag" action to vehicle. This will fail for some
 * vehicles, because not all vehicles should carry flags.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Action was added <BOOL>
 *
 * Example:
 * private _added = [_veh] call gradTnT_flag_fnc_addTakeAction;
 *
 * Public: No
 */
params [["_veh", objNull, [objNull]]];

if (isNull _veh) exitWith {
	["Vehicle must not be objNull."] call BIS_fnc_error;
	false;
};

if ((_veh isKindOf "gm_gc_army_t55am2b") || (_veh isKindOf "gm_ge_army_Leopard1a5")) exitWith {
    false;
};

private _action = [
    "gradTnT_flag_take",
    "Take Flag",
    "\A3\ui_f\data\igui\cfg\actions\takeflag_ca.paa",
    {
        [_player] call gradTnT_flag_fnc_take;
    },
    {   
        !([_player] call gradTnT_flag_fnc_has) && ([_target] call gradTnT_fnc_side) isEqualTo (side _player)
    },
    nil,
    nil,
    nil,
    5
] call ace_interact_menu_fnc_createAction;


[_veh, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

true;
