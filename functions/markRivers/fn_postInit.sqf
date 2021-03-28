/*
 * Name: gradTnT_markRivers_fnc_postInit
 * Author: DerZade
 * Automatically called postInit.
 * Adds draw eventhandler to all players an starts calculation of rivers on server.
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
			(_disp displayCtrl 51) ctrlAddEventHandler ["draw", gradTnT_markRivers_fnc_draw];
		},
		[]
	] call CBA_fnc_waitUntilAndExecute;
};

if (isServer) then {
	[] call gradTnT_markRivers_fnc_calculateRivers;
};