/*
 * Name: gradTnT_callsign_fnc_set
 * Author: DerZade
 * Get allowed callsign suffixes for prefix.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Callsign. Array including two or three strings [prefix, suffix, tacticalNumber] <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_veh, ["A", "1", "1337"]] call gradTnT_callsign_fnc_set;
 *
 * Public: No
 */
params [
	["_veh", objNull, [objNull]],
	["_callsign", [], [[]], [2, 3]]
];

_callsign params [
	["_prefix", "A", [""]],
	["_suffix", "1", [""]],
	["_number", "", [""]]
];

_veh setVariable ["gradTnT_callsign", _callsign, true];

private _attributes = _veh getVariable ["gm_vehicle_attributes", []];
if (count _attributes isEqualTo 0) exitWith {};



if (_number isNotEqualTo "") then {
    private _font = [configFile >> "CfgVehicles" >> (typeOf _veh), "gm_TacticalNumbersFontNumbers", "gm_gc_schablonier_gry"] call BIS_fnc_returnConfigEntry;

    _attributes set [2, [_number, _font]];
};

_veh setVariable ["gm_vehicle_attributes", _attributes, true];
private _script = [_veh] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;

[{
    params ["_script"];
    scriptDone _script
},{
    params ["_script", "_veh", "_prefix", "_suffix"];
    
    // add after vehicleMarkingsInit as overwrites internal stuff
    private _allowedSuffixes = [_prefix] call gradTnt_callsign_fnc_allowedSuffixes;
    if (count _suffix isEqualTo 0 || _suffix in _allowedSuffixes) then {
        private _formationSign = format ["functions\callsign\data\%1%2.paa", _prefix, _suffix];
        [_veh, _formationSign] call gradTnt_callsign_fnc_addCustomFormationSign;
    };
}, [_script, _veh, _prefix, _suffix]] call CBA_fnc_waitUntilAndExecute;
