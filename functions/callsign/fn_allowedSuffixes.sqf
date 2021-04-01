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
#define ONE_TO_SEVEN ["1", "2", "3", "4", "5", "6", "7"]

params ["_prefix"];

private _map = createHashMapFromArray [
	["A", ONE_TO_SEVEN],
	["B", ONE_TO_SEVEN],
	["C", ONE_TO_SEVEN],
	["D", ONE_TO_SEVEN],
    ["E", ONE_TO_SEVEN],
    ["F", ONE_TO_SEVEN],
    ["G", ONE_TO_SEVEN],
    ["H", ONE_TO_SEVEN],
    ["I", ONE_TO_SEVEN],
    ["K", ONE_TO_SEVEN],
    ["L", ONE_TO_SEVEN],
    ["M", ONE_TO_SEVEN],
    ["N", ONE_TO_SEVEN],
    ["O", ONE_TO_SEVEN],
    ["P", ONE_TO_SEVEN],
    ["Q", ONE_TO_SEVEN],
    ["R", ONE_TO_SEVEN],
    ["S", ONE_TO_SEVEN],
    ["T", ONE_TO_SEVEN],
    ["U", ONE_TO_SEVEN],
    ["V", ONE_TO_SEVEN],
    ["W", ONE_TO_SEVEN],
    ["X", ONE_TO_SEVEN],
    ["Y", ONE_TO_SEVEN],
    ["Z", ONE_TO_SEVEN]
];

_map getOrDefault [_prefix, []];
