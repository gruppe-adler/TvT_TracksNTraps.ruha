/*
 * Name: gradTnT_callsign_fnc_addAction
 * Author: DerZade
 * Add "Change Callsign" action to vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_veh] call gradTnT_callsign_fnc_addAction;
 *
 * Public: No
 */
params ["_veh"];

private _action = [
    "gradTnT_callsign_change",
    "Change Callsign",
    "",
    {
        [_target] call gradTnT_callsign_fnc_openDisplay;
    },
	{
        ([_target, true] call BIS_fnc_objectSide) isEqualTo (side _player)
    },
	nil,
	nil,
	nil,
	3,
	[false, true, false, false, false]
] call ace_interact_menu_fnc_createAction;

[_veh, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;