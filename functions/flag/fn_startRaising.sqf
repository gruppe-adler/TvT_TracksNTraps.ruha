/*
 * Name: gradTnT_flag_fnc_startRaising
 * Author: nomisum, DerZade
 * Start raising flag for side. This sets the correct flag texture, and plays the national anthem.
 *
 * Arguments:
 * 0: Flag <OBJECT>
 * 1: Side <SIDE>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_flag, _side] call gradTnT_flag_fnc_startRaising;
 *
 * Public: No
 */
params [
	["_flag", objNull, [objNull]],
	["_side", sideUnknown, [sideUnknown]]
];

if (isNull _flag) exitWith {
	["Flag must not be objNull."] call BIS_fnc_error;
};

// set correct texture
private _texture = [_side] call gradTnT_flag_fnc_getTexture;
_flag setFlagTexture _texture;

// delete sound helper, if there is one
private _helper = _flag getVariable ["gradTnT_flag_soundHelper", objNull];
if !(isNull _helper) then {
	deleteVehicle _helper;
};

if (_side isEqualTo sideUnknown) exitWith {};

// play sound
private _speakers = _flag getVariable ["gradTnT_flag_speakers", objNull];
if !(isNull _speakers) then {
	private _pos = getPos _speakers,
	_pos set [2,3];

	private _helper = "Sign_Sphere25cm_Geometry_F" createVehicle [0,0,0];
	_helper setPos _pos;
	_helper setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];

	private _sound = ([
			"anthem_su",
			"anthem_ger"
	] select (_side isEqualTo west));

	[_helper, [_sound, 150, 1]] remoteExecCall ["say3D", 0];

	_flag setVariable ["gradTnT_flag_soundHelper", _helper, true];
};
