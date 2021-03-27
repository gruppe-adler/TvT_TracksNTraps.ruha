/*
 * Name: gradTnT_bft_fnc_add
 * Author: DerZade
 * Add bft marker to vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Overwrite Type (Optional) "air", "armor", "bridge", etc. <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_veh, "recon"] call gradTnT_bft_fnc_add;
 *
 * Public: No
 */
params [["_veh", objNull, [objNull]]];

if (isNull _veh) exitWith {
	["Vehicle must not be objNull."] call BIS_fnc_error;
};

// set type if it isn't already set
if ((_veh getVariable ["gradTnT_bft_type", ""]) isEqualTo  "") then {
    private _defaultType = [_veh] call gradTnT_bft_fnc_defaultType;

    private _type = param [1, _defaultType, [""]];

    _veh setVariable ["gradTnT_bft_type", _type, true];
};

private _side = [_veh] call gradTnT_fnc_side;

["gradTnT_bft_add", [_veh, _side]] call CBA_fnc_globalEvent;

_veh addMPEventHandler ["MPKilled", gradTnT_bft_fnc_onKilled];
