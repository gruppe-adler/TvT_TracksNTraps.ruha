/*
 * Name: gradTnT_flag_fnc_tick
 * Author: nomisum, DerZade
 * Called by per frame handler, checks the objective every second.
 *
 * Arguments:
 * 0: Flag <OBJECT>
 * 1: Trigger <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_flag, _trigger] call gradTnT_flag_fnc_tick;
 *
 * Public: No
 */
#define FLAG_PHASE_PER_INTERVAL 0.1

params [
	["_flag", objNull, [objNull]],
	["_trigger", objNull, [objNull]]
];

if (isNull _flag) exitWith {
	["Flag must not be objNull."] call BIS_fnc_error;
};

if (isNull _flag) exitWith {
	["Trigger must not be objNull."] call BIS_fnc_error;
};

// find all player which are in the trigger, within a vehicles and not unconscious
private _players = allPlayers select { (_x inArea _trigger) && ((vehicle _x) isNotEqualTo _x) && !(_x getVariable ["ACE_isUnconscious", false]) };

if (count _player isEqualTo 0) exitWith {};

private _capturingSides = [];
private _blockingSides = [];
{
	private _side = side _x;
	if ([_x] call gradTnT_flag_fnc_canRaise) then {
		_capturingSides pushBackUnique _side;
	} else {
		_blockingSides pushBackUnique _side;
	};
} forEach _players;

// we don't mind blocking sides, which are also capuring
_blockingSides = _blockingSides - _capturingSides;

private _captor = sideUnknown;
private _onlyNeutralizing = false;
if ((count _capturingSides) isEqualTo 1 && (count _blockingSides) isEqualTo 0) then {
	// if only one side is capable of capturing and no sides are blocking -> only side captures
	_captor = _capturingSides select 0;
};

if (count _blockingSides isEqualTo 1) then {
	_captor = _blockingSides select 0;
	_onlyNeutralizing = true;
};

if (_captor isEqualTo sideUnknown) exitWith {
	// exit if no side is capturing
};

private _owner = _flag getVariable ["gradTnT_flag_owner", sideUnknown];
if (_captor isEqualTo _owner) exitWith {
	// exit if capturing side already owns flag
};

// CAPTURING / NEUTRALIZING IS IN PROGRESS -----------------------------------------------------------------------------------

if (_owner isNotEqualTo sideUnknown) then {
	// no one should own the flag, if capturing is in progress
	_flag setVariable ["gradTnT_flag_owner", sideUnknown, true];
	["gradTnT_objectiveCaptured", [sideUnknown]] call CBA_fnc_globalEvent;
};

private _phase = flagAnimationPhase _flag;

if (_onlyNeutralizing && _phase isEqualTo 0) exitWith {
	_flag setFlagTexture "";
};

// if the flag is at the bottom the captor just changed
if (_phase isEqualTo 0) then {
	[_flag, _captor] call gradTnT_flag_fnc_startRaising;
	_flag setVariable ["gradTnT_flag_flagSide", _captor, true];
};

private _flagSide = _flag getVariable ["gradTnT_flag_flagSide", sideUnknown];
private _direction = [-1, 1] select (_flagSide isEqualTo _captor);

// check if flag has reached top
if (_direction > 0 && _phase >= 1) then {
	_flag setVariable ["gradTnT_flag_owner", _captor, true];
	
	// trigger captured event
	["gradTnT_objectiveCaptured", [_captor]] call CBA_fnc_globalEvent;
};

// animate flag to correct position
[
	_flag,
	_phase + FLAG_PHASE_PER_INTERVAL * _direction
] call BIS_fnc_animateFlag;
