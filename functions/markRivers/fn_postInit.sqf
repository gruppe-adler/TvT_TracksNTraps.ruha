/*
 * Name: gradTnT_markRivers_fnc_postInit
 * Author: DerZade
 * Automatically called postInit.
 * Starts calculation of rivers on server.
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

if (isServer) then {
	[] call gradTnT_markRivers_fnc_calculateRivers;
};