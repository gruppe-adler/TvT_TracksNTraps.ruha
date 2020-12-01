/*
 * Name: gradSB_fnc_vehicleRespawnAdd
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
 * [_obj] call gradSB_fnc_vehicleRespawnAdd;
 *
 * Public: No
 */
params [["_veh", objNull, [objNull]]];

// exit if this is no the server
if (!isServer) exitWith {};

if (isNull _veh) exitWith {
    diag_log format ["grad-vehicleRespawn: failed add respawn to vehicle, because it was objNull"]
};

diag_log format ["grad-vehicleRespawn: adding %1 to respawn", _veh];

// add killed EH
private _killedID = _veh addMPEventHandler ["MPKilled", {
    params ["_vehicle"];
    if (!isServer) exitWith {};
    [_vehicle] call gradSB_fnc_vehicleRespawnTrigger;
}];

// add deleted EH
private _deletedID = _veh addEventHandler ["Deleted", {
    params ["_vehicle"];
    if (!isServer) exitWith {};
    [_vehicle] call gradSB_fnc_vehicleRespawnTrigger;
}];

// set variable
_veh setVariable [
    "gradSB_vehicleRespawn",
    [
        getPos _vehObj,
        getDir _vehObj,
        _killedID,
        _deletedID
    ],
    true
];
