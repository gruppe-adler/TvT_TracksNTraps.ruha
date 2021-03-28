/*
 * Name: gradTnT_vehicleRespawn_fnc_trigger
 * Author: DerZade
 * Initiates respawn. Called by Deleted / Killed EH of vehicle.
 *
 * Arguments:
 * 0: Old vehicle <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_oldVehicle] call gradTnT_vehicleRespawn_fnc_trigger;
 *
 * Public: No
 */
#include "respawnVariables.hpp"

params ["_veh"];

if (!isServer) exitWith {};

private _var = _veh getVariable ["gradTnT_vehicleRespawn", []];
if !((count _var) isEqualTo 4) exitWith {
    // TODO: Log Error
};
_var params [["_respawnPos", [0,0,0], [[]], [3]], ["_respawnDir", 0, [0]], ["_killedEH", -1, [0]], ["_deletedEH", -1, [0]]];
_veh setVariable ["gradTnT_vehicleRespawn", nil];

// remove EHs just to be save any of won't trigger multiple times
_veh removeMPEventHandler ["MPKilled", _killedEH];
_veh removeEventHandler ["Deleted", _deletedEH];

// remember all RESPAWN_VARIABLE_NAMES of old vehicle 
private _variables = [];
{
    private _value = _veh getVariable _x;
    _variables pushBack [_x, _value];
} forEach RESPAWN_VARIABLE_NAMES;


private _respawnArgs = [
    typeOf _veh,
    _respawnPos,
    _respawnDir,
    _variables
];

// try to respawn vehicle every 5s
[
    {
        params ["_args", "_handle"];

        private _isRespawned = _args call gradTnT_vehicleRespawn_fnc_tryRespawn;

        if (_isRespawned) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
    },
    5,
    _respawnArgs
] call CBA_fnc_addPerFrameHandler;
