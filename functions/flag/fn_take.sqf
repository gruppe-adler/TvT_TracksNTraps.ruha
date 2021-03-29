/*
 * Name: gradTnT_flag_fnc_take
 * Author: nomisum
 * Called by take action. Adds flag to unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call gradTnT_flag_fnc_take;
 *
 * Public: No
 */
params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {
	["Unit must not be objNull."] call BIS_fnc_error;
};

private _dummyFlag = "Flag_Red_F" createVehicle [-1000,-1000,0];
_dummyFlag setFlagTexture ([side _unit] call gradTnT_flag_fnc_getTexture);

[_dummyFlag, 0, true] call BIS_fnc_animateFlag;

_dummyFlag setFlagOwner _unit;
_unit setVariable ["gradTnT_flag_dummyFlag", _dummyFlag, true];

// TODO: Remove this. This should not be a waitUntilAndExecute, but be done within the flagRaise function
[{
    params ["_dummyFlag", "_unit"];
    _unit getVariable ["gradTnT_flagRaising", false]
},
{
    params ["_dummyFlag", "_unit"];
    _dummyFlag setFlagOwner objNull;
    deleteVehicle _dummyFlag;
    _unit setVariable ["gradTnT_flag_dummyFlag", objNull, true];
},[_dummyFlag, _unit]] call CBA_fnc_waitUntilAndExecute;