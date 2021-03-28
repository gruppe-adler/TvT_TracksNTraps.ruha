/*
 * Name: gradTnT_map_fnc_setupCtrl
 * Author: DerZade
 * Setup draw handler for map control.
 *
 * Arguments:
 * 0: Map <CONTROL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */
params ["_ctrl"];

_ctrl ctrlAddEventHandler ["draw", gradTnT_bft_fnc_draw];
_ctrl ctrlAddEventHandler ["draw", gradTnT_fnc_flagMapMarker];
_ctrl ctrlAddEventHandler ["draw", gradTnT_markRivers_fnc_draw];
