/*
 * Name: gradTnT_vehicleRespawn_fnc_add
 * Author: DerZade
 * Adds vehicle as respawnable vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_obj] call gradTnT_vehicleRespawn_fnc_add;
 *
 * Public: No
 */
params [["_veh", objNull, [objNull]]];

// exit if this is not the client where _veh is local
if (!local _veh) exitWith {
    _this remoteExec ["gradTnT_vehicleRespawn_fnc_add", _veh];
};

if (isNull _veh) exitWith {
    ["failed add respawn to vehicle, because it was objNull"] call BIS_fnc_error;
};

if (count (_veh getVariable ["gradTnT_vehicleRespawn", []]) > 0) exitWith {
    ["failed add respawn to vehicle %1, because it is already added as respawnable", _veh] call BIS_fnc_error;
};

["adding %1 to respawn", _veh] call BIS_fnc_log;

// add killed EH
private _killedID = _veh addEventHandler ["Killed", gradTnT_vehicleRespawn_fnc_trigger];

// add deleted EH
private _deletedID = _veh addEventHandler ["Deleted", gradTnT_vehicleRespawn_fnc_trigger];

// set variable
_veh setVariable [
    "gradTnT_vehicleRespawn",
    [
        getPos _veh,
        getDir _veh,
        _killedID,
        _deletedID
    ],
    true
];
