/*
 * Name: gradTnT_forceRespawn_fnc_addAction
 * Author: DerZade
 * Add "Force Vehicle Respawn" action to flag in the base.
 *
 * Arguments:
 * 0: Flag <OBJECT>
 * 1: Flag side <SIDE>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_flag, west] call gradTnT_forceRespawn_fnc_addAction;
 *
 * Public: No
 */
params ["_flag", "_side"];

_flag setVariable ["gradTnT_forceRespawn_side", _side];

private _action = [
	"gradTnT_forceRespawn",
	"Force Vehicle Respawn",
	"",
	{
		[{[] call gradTnT_forceRespawn_fnc_openDisplay;} ] call CBA_fnc_execNextFrame;
	},
	{
		(side _player) isEqualTo (_target getVariable "gradTnT_forceRespawn_side")
	},
	nil,
	nil,
    [0,-0.35,-2.6],
	3,
    [false, false, false, false, false]
] call ace_interact_menu_fnc_createAction;

[_flag, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;