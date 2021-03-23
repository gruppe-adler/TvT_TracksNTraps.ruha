/*
 * Name: gradTnT_callsign_fnc_allowedSuffixes
 * Author: DerZade
 * Get allowed callsign suffixes for prefix.
 *
 * Arguments:
 * 0: Prefix <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * ["A"] call gradTnT_callsign_fnc_allowedSuffixes;
 *
 * Public: No
 */
#define ONE_TO_FOUR ["1", "2", "3", "4"]

params ["_prefix"];

private _map = createHashMapFromArray [
	["A", ONE_TO_FOUR],
	["B", ONE_TO_FOUR],
	["C", ONE_TO_FOUR],
	["D", ONE_TO_FOUR]
];

_map getOrDefault [_prefix, []];
