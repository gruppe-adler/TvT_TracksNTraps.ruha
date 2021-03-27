/*
 * Name: gradTnT_bft_fnc_preInit
 * Author: DerZade
 * Automatically called by preInit.
 * Setup for all CBA Event handlers and required variables.
 * 
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

if (isServer && isNil "gradTnT_bft_vehicles") then {
	gradTnT_bft_vehicles = createHashMap;
};

if (isNil "gradTnT_bft_vehicles") then {
	// ask server to send current list so we have a local copy
	// server will never enter here because we just set the var if it was nil
	[	
		[],
		{
			remoteExecutedOwner publicVariableClient "gradTnT_bft_vehicles";
		}
	] remoteExec ["call", 2];
};

// Handler for adding vehicles to local list
[
	"gradTnT_bft_add",
	{
		params ["_veh", "_side"];

		if (isNil "gradTnT_bft_vehicles") exitWith {
			["Someting went wrong and we received an add event before the variable was initialized."] call BIS_fnc_error;
		};

		private _sideVehicles = gradTnT_bft_vehicles getOrDefault [_side, [], true];
		_sideVehicles pushBackUnique _veh;

		gradTnT_bft_vehicles set [_side, _sideVehicles];
	}
] call CBA_fnc_addEventHandler;

// Handler for remove vehicles from local list
[
	"gradTnT_bft_remove",
	{
		params ["_veh"];

		if (isNil "gradTnT_bft_vehicles") exitWith {
			["Someting went wrong and we received an remove event before the variable was initialized."] call BIS_fnc_error;
		};

		// remove vehicle from all sides
		{
			_y deleteAt (_y find _veh);
			gradTnT_bft_vehicles set [_x, _y];
		} forEach gradTnT_bft_vehicles;
	}
] call CBA_fnc_addEventHandler;
