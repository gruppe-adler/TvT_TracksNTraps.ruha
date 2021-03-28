/*
 * Name: gradTnT_bft_fnc_onKilled
 * Author: DerZade
 * Called by MPKilled event handler of a BFT vehicle.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */
params ["_veh"];

if (_veh getVariable ["gradTnT_bft_destroyedTime", -1] > -1) exitWith {};

if (!isServer) exitWith {
	_this remoteExecCall ["gradTnT_bft_fnc_onKilled", 2];
};

// save time when vehicle got destroyed
_veh setVariable ["gradTnT_bft_destroyedTime", CBA_missionTime, true];

// trigger event after 310s to remove vehicle
[
	CBA_fnc_globalEvent, 
	["gradTnT_bft_remove", [_veh]],
	310
] call CBA_fnc_waitAndExecute;