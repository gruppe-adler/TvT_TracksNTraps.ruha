/*
 * Name: gradTnT_fnc_side
 * Author: DerZade
 * Get assigned side for vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Vehicle side <SIDE>
 *
 * Example:
 * [_veh] call gradTnT_fnc_side;
 *
 * Public: No
 */
params ["_veh"];

_veh getVariable ["gradTnT_vehicleSide", [_veh, true] call BIS_fnc_objectSide];

