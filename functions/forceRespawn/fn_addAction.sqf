params ["_flag", "_side"];

_flag setVariable ["gradTnT_forceRespawn_side", _side];

private _action = [
	"gradTnT_forceRespawn",
	"Force Vehicle Respawn",
	"",
	{
		[] call gradTnT_forceRespawn_fnc_openDisplay;
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