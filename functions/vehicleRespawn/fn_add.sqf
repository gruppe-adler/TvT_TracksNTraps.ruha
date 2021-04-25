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


private _vehicleID = _veh getVariable ["gradTnT_vehicleRespawn", []] param [4, -1]; // get param 4 of variable
// if no ID assigned, assign ID 
if (_vehicleID < 0) then {
    private _newVehicleID = (missionNamespace getVariable ["gradTnT_vehicleCount", 0]) + 1;
    _vehicleID = _newVehicleID;
    missionNamespace setVariable ["gradTnT_vehicleCount", _vehicleID, true];
    _veh setVariable ["gradTnT_vehicleID", _vehicleID, true];
};

["adding %1 with ID %2 to respawn", _veh, _vehicleID] call BIS_fnc_log;

// add killed EH
private _killedID = _veh addMPEventHandler ["MPKilled", {
    if (!isServer) exitWith {};
    _this call gradTnT_vehicleRespawn_fnc_trigger;
}];

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
