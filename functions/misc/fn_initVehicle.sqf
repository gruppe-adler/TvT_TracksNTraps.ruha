/*
 * Name: gradTnT_fnc_initVehicle
 * Author: DerZade
 * Initialize everything for vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Default Callsign. Array including two or three strings [prefix, suffix, tacticalNumber] <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, ["B", "2"]] call gradTnT_fnc_initVehicle;
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
[_veh] call gradTnT_fnc_bftAdd;

private _callsign = param [1, (_veh getVariable ["gradTnT_callsign", ["A", "1"]]), [[]], [2, 3]];
[_veh, _callsign] call gradTnT_callsign_fnc_set;
[_veh] remoteExecCall ["gradTnT_callsign_fnc_addAction", 0, true];

// flag for capturing only on engineer vehicles
private _side = [_veh, true] call BIS_fnc_objectSide;
if (_veh getVariable ["ace_isRepairVehicle", -1] == 1) then {
    [_veh] remoteExecCall ["gradTnT_fnc_flagTakeAction", _side, true];
};
