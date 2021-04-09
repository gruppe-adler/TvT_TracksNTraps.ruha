/*
 * Name: gradTnT_flag_fnc_canRaise
 * Author: nomisum
 * Check whether player can raise flag.
 * This is used a condition for the raise flag action.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Player can raise flag <BOOL>
 *
 * Example:
 * private _canRaise = [_player] call gradTnT_flag_fnc_canRaise;
 *
 * Public: No
 */
params ["_player"];

(typeof vehicle _player) isEqualTo "gm_ge_army_bpz2a0"
