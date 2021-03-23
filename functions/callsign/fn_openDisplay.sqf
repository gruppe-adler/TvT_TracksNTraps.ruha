/*
 * Name: gradTnT_callsign_fnc_openDisplay
 * Author: DerZade
 * Open "Change Callsign" display for vehicle. This function will also take care 
 * of filling the combo boxes, and adding all needed event handlers.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_veh] call gradTnT_callsign_fnc_openDisplay;
 *
 * Public: No
 */
#include "idcmacros.hpp"

params ["_veh"];

(_veh getVariable ["gradTnT_callsign", []]) params [
	["_prefix", "A", [""]],
	["_suffix", "1", [""]],
	["_number", "", [""]]
];

private _display = findDisplay 46 createDisplay "gradTnT_changeVehicleCallsign";

_display setVariable ["gradTnT_vehicle", _veh];

private _prefixCtrl = _display displayCtrl IDC_PREFIX;
private _suffixCtrl = _display displayCtrl IDC_SUFFIX;
private _numberCtrl = _display displayCtrl IDC_NUMBER;

// SUFFIX COMBO ----------------------------------------------------------------------------------------------
// we do not need to fill this, because it will be filled by the LBSelChanged EH 
// of the prefix combo, once it will be filled we'll add and select the current 
// suffix tho, to make sure it will be selected if it is within the allowed suffixes
private _index = _suffixCtrl lbAdd _suffix;
_suffixCtrl lbSetCurSel _index;

// PREFIX COMBO ----------------------------------------------------------------------------------------------
lbClear _prefixCtrl;

private _indexToSelect = 0;
{
	private _index = _prefixCtrl lbAdd _x;

	if (_x isEqualTo _prefix) then {
		_indexToSelect = _index;
	};
} forEach ALLOWED_PREFIXES;

// we want to update the available callsign suffixes when callsign prefix changes
_prefixCtrl ctrlAddEventHandler ["LBSelChanged", {
	params ["_prefixCtrl", "_selectedIndex"];

	if (_selectedIndex isEqualTo -1) exitWith {};

	private _suffixCtrl = (ctrlParent _prefixCtrl) displayCtrl IDC_SUFFIX;

	// remember selected suffix
	private _curSuffix = _suffixCtrl lbText (lbCurSel _suffixCtrl);

	private _allowedSuffixes = [_prefixCtrl lbText _selectedIndex] call gradTnT_callsign_fnc_allowedSuffixes;

	lbClear _suffixCtrl;
	_suffixCtrl ctrlEnable (count _allowedSuffixes > 0);

	{
		private _index = _suffixCtrl lbAdd _x;

		if (_x isEqualTo _curSuffix) then {
			_suffixCtrl lbSetCurSel _index;
		};
	} forEach _allowedSuffixes;

	// select first entry by default
	if (lbCurSel _prefixCtrl isEqualTo -1) then { _prefixCtrl lbSetCurSel 0; };
}];

_prefixCtrl lbSetCurSel _indexToSelect;

// NUMBER EDIT -----------------------------------------------------------------------------------------------
_numberCtrl ctrlSetText _number;

// prevent user to type anything but ALLOWED_CHARS_IN_NUMBER
_numberCtrl ctrlAddEventHandler ["Char", {
	_this spawn {
		params ["_ctrl", "_charCode"];

		private _arr = (ctrlText _ctrl) splitString '';
		_ctrl ctrlSetText ((_arr select {_x in ALLOWED_CHARS_IN_NUMBER}) joinString '');
	};
}];

// Unload EH -------------------------------------------------------------------------------------------------
_display displayAddEventHandler ["UnLoad", {
	params ["_display", "_exitCode"];

	if (_exitCode isNotEqualTo 1) exitWith {};

	private _veh = _display getVariable "gradTnT_vehicle";

	private _prefixCtrl = _display displayCtrl IDC_PREFIX;
	private _suffixCtrl = _display displayCtrl IDC_SUFFIX;
	private _numberCtrl = _display displayCtrl IDC_NUMBER;

	private _prefix = _prefixCtrl lbText (lbCurSel _prefixCtrl);
	private _suffix = _suffixCtrl lbText (lbCurSel _suffixCtrl);
	private _number = ctrlText _numberCtrl;

	[_veh, [_prefix, _suffix, _number]] call gradTnT_callsign_fnc_set;
}];