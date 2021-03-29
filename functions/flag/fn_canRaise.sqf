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
 * private _canRaise = [player, _flag] call gradTnT_flag_fnc_canRaise;
 *
 * Public: No
 */
params ["_player", "_flag"];

(_flag getVariable ["gradTnT_flagOwner", sideUnknown] isNotEqualTo (side _player)) &&
!(_flag getVariable ["gradTnT_flagAnimation", false]) &&
[_player] call gradTnT_flag_fnc_has