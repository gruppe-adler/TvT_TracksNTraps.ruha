/*
 * Name: gradTnT_vehicleRespawn_fnc_tryRespawn
 * Author: DerZade
 * Tries to respawn vehicle. Respawn can fail if given position doesn't have enough room.
 *
 * Arguments:
 * 0: Type <STRING>
 * 1: Respawn position <ARRAY>
 * 2: Respawn direction <NUMBER>
 * 3: Variables from old vehicle <ARRAY>
 *
 * Return Value:
 * Respawn was successful? <BOOL>
 *
 * Example:
 * private _successful = ["", [0,0,0], 20, []] call gradTnT_vehicleRespawn_fnc_tryRespawn;
 *
 * Public: No
 */

params [["_type", "", [""]], ["_pos", [0,0,0], [[]], [3]], ["_dir", 0, [0]], ["_variables", [], [[]]]];

// SizeOf: At least one object of the given classname has to be present in the current mission otherwise zero will be returned
private _sizeDummy = _type createVehicleLocal [0,0,0];
private _dimensions = sizeOf typeOf _sizeDummy;
deleteVehicle _sizeDummy;

private _positionEmpty = nearestObjects [_pos, ["Man", "LandVehicle", "Air"], _dimensions/1.5];
private _isRoom = count _positionEmpty isEqualTo 0;

// exit if position isn't empty
if (!_isRoom) exitWith {
    private _side = [west, east] select ({ _x select 1 == west } count _variables > 0);
    private _identifier = format ["gradTnT_waitingForRespawn_%1", _side];
    private _waitingForRespawn = missionNamespace getVariable [_identifier, []];
    _waitingForRespawn pushBackUnique [_type, _pos];
    missionNamespace setVariable [_identifier, _waitingForRespawn, true];
    diag_log format ["%2 respawn queue: %1", _waitingForRespawn, _side];
	false;
};

 private _waitingForRespawn = missionNamespace getVariable ["gradTnT_waitingForRespawn", []];
_waitingForRespawn deleteAt (_waitingForRespawn find [_type, _pos]);
missionNamespace setVariable ["gradTnT_waitingForRespawn", _waitingForRespawn, true];

// spawn vehicle
private _veh = createVehicle [ _type, [0,0,0], [], 0, "NONE" ];
_pos set [2, 1];
_veh setPos _pos;
_veh setDir _dir;

// copy variables from old vehicle
{
	_x params ["_name", "_val"];
	_veh setVariable [_name, _val, true];
} forEach _variables;

// trigger server event
// 0: New vehicle <OBJECT>
// 1: Variables <ARRAY> (Variables is a pairs array. Each pair is [<name>, <value>])
["gradTnT_vehicleRespawn", [_veh, _variables]] call CBA_fnc_serverEvent;

true;
