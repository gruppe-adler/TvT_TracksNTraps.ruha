/*
 * Name: gradTnT_forceRespawn_fnc_postInit
 * Author: DerZade
 * Automatically called postInit. Setup missionNamespace variable
 * gradTnT_forceRespawn_vehicles and event GetInMan handler to fill that array.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call gradTnT_forceRespawn_fnc_postInit;
 *
 * Public: No
 */
if (!hasInterface) exitWith {};

gradTnT_forceRespawn_vehicles = [];

if ((vehicle player) isNotEqualTo player) then {
	gradTnT_forceRespawn_vehicles pushBackUnique (vehicle player);
};

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	gradTnT_forceRespawn_vehicles pushBackUnique _vehicle;
}];
