/*
 * Name: gradTnT_fnc_initVehicle
 * Author: DerZade
 * Initialize everything for vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Default Callsign <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, "B2"] call gradTnT_fnc_initVehicle;
 *
 * Public: No
 */

params [["_veh", objNull, [objNull]], ["_callsignPrefix", "A"], ["_callsignSuffix", "1"]];

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
[_veh, _callsignPrefix, _callsignSuffix] call gradTnT_fnc_bftAdd;
[_veh] remoteExecCall ["gradTnT_fnc_addVehicleAction", 0, true];
// add existing vehicles to system


// private _side = [_veh, true] call BIS_fnc_objectSide;
