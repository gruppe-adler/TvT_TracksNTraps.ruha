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

if (isNull _veh) exitWith {
	["Vehicle must not be objNull."] call BIS_fnc_error;
};

private _vehicleID = _veh getVariable ["gradTnT_vehicleID", -1];
["trigger respawning %1 with ID %2 to respawn", _veh, _vehicleID] call BIS_fnc_log;

private _var = _veh getVariable ["gradTnT_vehicleRespawn", []];
if !((count _var) isEqualTo 4) exitWith {
    ["Respawn was already triggered for vehicle."] call BIS_fnc_error;
};
_var params [["_respawnPos", [0,0,0], [[]], [3]], ["_respawnDir", 0, [0]], ["_killedEH", -1, [0]], ["_deletedEH", -1, [0]]];
_veh setVariable ["gradTnT_vehicleRespawn", nil, true];

private _customAttributes = [_veh] call bis_fnc_getVehicleCustomization;
_veh setVariable ["gradTnT_vehicleCustomization", _customAttributes, true];


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

        diag_log "trying to respawn";
        private _isRespawned = _args call gradTnT_vehicleRespawn_fnc_tryRespawn;
        
        if (_isRespawned) then {
            diag_log "successfully respawned";
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
    },
    5,
    _respawnArgs
] remoteExecCall ["CBA_fnc_addPerFrameHandler", 2];
