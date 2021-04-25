/*
 * Name: gradTnT_forceRespawn_fnc_openDisplay
 * Author: DerZade
 * Open "Force Vehicle Respawn" display. This function will also take care 
 * of filling the combo boxes, and adding all needed event handlers.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call gradTnT_forceRespawn_fnc_openDisplay;
 *
 * Public: No
 */
#define IDC_COMBO 1337
#define IDC_MAP 1338
#define IDC_HINT 1339
#define IDC_BTN 1

// find vehicles unit entered which aren't null, are alive and on the player's side
private _vehicles = gradTnT_forceRespawn_vehicles select { !(isNull _x) && alive _x && ([_x] call gradTnT_fnc_side) isEqualTo playerSide };

if (count _vehicles isEqualTo 0) exitWith {
	// TODO
	systemChat "You don't have any vehicles to respawn. You can only force respawn vehicles you've entered.";

	private _waitingForRespawn = missionNamespace getVariable ["gradTnT_waitingForRespawn", []];
	systemChat format ["No respawn due to no room: %1", _waitingForRespawn];
};

private _display = findDisplay 46 createDisplay "gradTnT_forceVehicleRespawn";

_display setVariable ["gradTnT_forceRespawn_vehicles", _vehicles];

private _comboCtrl = _display displayCtrl IDC_COMBO;
private _mapCtrl = _display displayCtrl IDC_MAP;

// MAP -------------------------------------------------------------------------------------------------------
[_mapCtrl] call gradTnT_map_fnc_setupCtrl;

// COMBO -----------------------------------------------------------------------------------------------------
_comboCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_comboCtrl", "_selectedIndex"];

	if (_selectedIndex isEqualTo -1) exitWith {};

	private _display = ctrlParent _comboCtrl;
	private _vehicles = _display getVariable "gradTnT_forceRespawn_vehicles";

	private _selectedVeh = _vehicles select _selectedIndex;

	// animate map to vehicle
	private _mapCtrl = _display displayCtrl IDC_MAP;
	ctrlMapAnimClear _mapCtrl;
	_mapCtrl ctrlMapAnimAdd [1, 0.05, getPos _selectedVeh];
	ctrlMapAnimCommit _mapCtrl;

	private _crew = (fullCrew _selectedVeh) select { alive (_x#0) };

	private _canSumbit = (count _crew) isEqualTo 0;
	(_display displayCtrl IDC_HINT) ctrlShow !_canSumbit;
	(_display displayCtrl IDC_BTN) ctrlShow _canSumbit;
}];

// add vehicles
{
	(_x getVariable ["gradTnT_callsign", ["A", "1"]]) params ["_prefix", "_suffix"];
	_comboCtrl lbAdd format ["%1-%2 @ %3", _prefix, _suffix, mapGridPosition _x];
} forEach _vehicles;

_comboCtrl lbSetCurSel 0;

// Unload EH -------------------------------------------------------------------------------------------------
_display displayAddEventHandler ["UnLoad", {
	params ["_display", "_exitCode"];

	if (_exitCode isNotEqualTo 1) exitWith {};

	private _vehicles = _display getVariable "gradTnT_forceRespawn_vehicles";
	private _selectedVeh = _vehicles select (lbCurSel (_display displayCtrl IDC_COMBO));

	[_selectedVeh] spawn {
		params ["_veh"];

		// TODO: Use custom GUI message
		private _result = [
			"Are you sure you want to respawn the vehicle?<br/><t size='0.8'>(This will grant the enemy victory points, as if they had destroyed it)</t>",
			"Force Respawn Vehicle",
			"Respawn",
			true
		] call BIS_fnc_guiMessage;

		if (!_result) exitWith {};

		_veh setDamage [1, false];
	}
}];