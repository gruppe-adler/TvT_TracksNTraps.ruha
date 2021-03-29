/*
 * Name: gradTnT_flag_fnc_has
 * Author: nomisum
 * Check whether player has a flag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Player has a flag <BOOL>
 *
 * Example:
 * private _hasFlag = [player] call gradTnT_flag_fnc_has;
 *
 * Public: No
 */
params [["_player", objNull, [objNull]]];

if (isNull _player) exitWith {
	["Player must not be objNull."] call BIS_fnc_error;
	false;
};

!isNull (_player getVariable ["gradTnT_flag_dummyFlag", objNull])