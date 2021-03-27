/*
 * Name: gradTnT_fnc_initVehicle
 * Author: DerZade
 * Initialize everything for vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Default Callsign. Array including two or three strings [prefix, suffix, tacticalNumber] (Optional) <ARRAY>
 * 2: Overwrite vehicle side  (Optional) <SIDE>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, ["B", "2"], east] call gradTnT_fnc_initVehicle;
 *
 * Public: No
 */

params [
    ["_veh", objNull, [objNull]]
];

// exit if this is no the server
if (!isServer) exitWith {};

if (isNull _veh) exitWith {};

clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

[_veh] call gradTnT_fnc_vehicleRespawnAdd;
[_veh] call gradTnT_fnc_addExplosiveAction;
[_veh] call gradTnT_fnc_damageHandling;
[_veh] call gradTnT_bft_fnc_add;

private _callsign = param [1, (_veh getVariable ["gradTnT_callsign", ["A", "1"]]), [[]], [2, 3]];
[_veh, _callsign] call gradTnT_callsign_fnc_set;
[_veh] remoteExecCall ["gradTnT_callsign_fnc_addAction", 0, true];

private _side = param [2, [_veh, true] call BIS_fnc_objectSide, [sideUnknown]];
_veh setVariable ["gradTnT_vehicleSide", _side, true];
_veh setVariable ["tf_side", str _side, true];
_veh setVariable ["tf_hasRadio", true, true];

// flag for capturing only on non tank vehicles
if (!(_veh isKindOf "gm_tracked_Tank_base")) then {
    [_veh] remoteExecCall ["gradTnT_fnc_flagTakeAction", _side, true];
};


// assign side to vehicle
if (_veh isKindOf "gm_ge_army_bpz2a0") then {
    _veh setVariable ["gradTnT_isRepairTank", true, true];
} else {
    _veh setVariable ["gradTnT_isRepairTank", false, true]; // todo necessary to set respawn var even when false?
};
