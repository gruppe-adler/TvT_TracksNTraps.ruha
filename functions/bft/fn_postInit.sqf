/*
 * Name: gradTnT_bft_fnc_postInit
 * Author: DerZade
 * Automatically called postInit. Adds draw eventhandler to all players.
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

if (hasInterface) then {
	[
		{
			! isNull (findDisplay 12)
		},
		{
			private _disp = findDisplay 12;
			(_disp displayCtrl 51) ctrlAddEventHandler ["draw", gradTnT_bft_fnc_draw];
		},
		[]
	] call CBA_fnc_waitUntilAndExecute;
};