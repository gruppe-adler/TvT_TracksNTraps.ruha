/*
 * Name: gradTnT_map_fnc_postInit
 * Author: DerZade
 * Automatically called postInit. Set up map / gps / respawn map screen.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

[
	{
		! isNull (findDisplay 12)
	},
	{
		private _display = findDisplay 12;
		[_display displayCtrl 51] call gradTnT_map_fnc_setupCtrl;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;

[
	{
		! isNull (uiNamespace getVariable ["RscCustomInfoMiniMap", displayNull])
	},
	{
		private _display = uiNamespace getVariable ["RscCustomInfoMiniMap", displayNull];
        private _miniMap = (_display displayCtrl 13301) controlsGroupCtrl 101;
		_miniMap setVariable ["gradTnT_bft_textColor", [0.5, 0.5, 0.5]];
		[_miniMap] call gradTnT_map_fnc_setupCtrl;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;

[
	{
		! isNull (uiNamespace getVariable ["RscDisplayRespawn", displayNull])
	},
	{
		private _display = uiNamespace getVariable ["RscDisplayRespawn", displayNull];
		[_display displayCtrl 1050] call gradTnT_map_fnc_setupCtrl;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;