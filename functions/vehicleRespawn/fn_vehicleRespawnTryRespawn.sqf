/*
 * Name: gradTnT_fnc_vehicleRespawnTryRespawn
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
 * private _successful = ["", [0,0,0], 20, []] call gradTnT_fnc_vehicleRespawnTryRespawn;
 *
 * Public: No
 */

params [["_type", "", [""]], ["_pos", [0,0,0], [[]], [3]], ["_dir", 0, [0]], ["_variables", [], [[]]]];

private _positionEmpty = nearestObjects [_pos, ["Man", "LandVehicle", "Air"], (sizeOf _type)/2];
private _isRoom = count _positionEmpty isEqualTo 0;

// exit if position isn't empty
if (!_isRoom) exitWith { false; };

// spawn vehicle
private _veh = createVehicle [ _type, [0,0,0], [], 0, "NONE" ];
_pos set [2, 1];
_veh setPos _pos;
_veh setDir _dir;

// copy variables from old vehicle
{
	_x params ["_name", "_val"];
	_veh setVariable [_name, _val];
} forEach _variables;

// add vehicle as respawnable
[_veh] call gradTnT_fnc_vehicleRespawnAdd;

// trigger server event
// 0: New vehicle <OBJECT>
// 1: Variables <ARRAY> (Variables is a pairs array. Each pair is [<name>, <value>])
["gradTnT_vehicleRespawn", [_veh, _variables]] call CBA_fnc_serverEvent;

true;