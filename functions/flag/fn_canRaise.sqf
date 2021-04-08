/*
 * Name: gradTnT_flag_fnc_canRaise
 * Author: nomisum
 * Check whether player can raise flag.
 * This is used a condition for the raise flag action.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Flag <OBJECT>
 *
 * Return Value:
 * Player can raise flag <BOOL>
 *
 * Example:
 * private _canRaise = [_flag, _player] call gradTnT_flag_fnc_canRaise;
 *
 * Public: No
 */
params ["_flag", "_player"];

(
    (_flag getVariable ["gradTnT_flagOwner", sideUnknown] isNotEqualTo (side _player) && typeOf vehicle _player == "gm_ge_army_bpz2a0") ||
    ((_flag getVariable ["gradTnT_flagOwner", sideUnknown] isNotEqualTo sideUnknown) && typeOf vehicle _player != "gm_ge_army_bpz2a0")
) && !(_flag getVariable ["gradTnT_flagAnimation", false])
&& side _player isNotEqualTo sideUnknown