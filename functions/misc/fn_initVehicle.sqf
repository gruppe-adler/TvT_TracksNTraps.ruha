/*
 * Name: gradTnT_fnc_initVehicle
 * Author: nomisum, DerZade
 * Initialize everything for vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Default Callsign. Array including two or three strings [prefix, suffix, tacticalNumber] (Optional) <ARRAY>
 * 2: Overwrite vehicle side  (Optional) <SIDE>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, ["B", "2"], east] call gradTnT_fnc_initVehicle;
 *
 * Public: No
 */

params [
    ["_veh", objNull, [objNull], ["_engineerVehicle", false]]
];

// exit if this is no the server
if (!isServer) exitWith {};

if (isNull _veh) exitWith {};

clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;


private _customization = _veh getVariable ["gradTnT_vehicleCustomization", []];
if (count _customization < 1) then {
    _customization = [_veh] call bis_fnc_getVehicleCustomization;
};
_customization params ["_textures", "_animations"];
[_veh, _textures, _animations] call BIS_fnc_initVehicle;

private _callsign = param [1, (_veh getVariable ["gradTnT_callsign", ["A", "1"]]), [[]], [2, 3]];

// delay callsign because gm init scripts are running automatically
[{
    params ["_veh", "_callsign"];
    [_veh, _callsign] call gradTnT_callsign_fnc_set;
}, [_veh, _callsign], 3] call CBA_fnc_waitAndExecute;


[_veh] remoteExecCall ["gradTnT_callsign_fnc_addAction", 0, true];

private _side = param [2, [_veh] call gradTnT_fnc_side, [sideUnknown]];
_veh setVariable ["gradTnT_vehicleSide", _side, true];
_veh setVariable ["tf_side", str _side, true];
_veh setVariable ["tf_hasRadio", true, true];
_veh setVariable ["ace_cookoff_enable", 0, true];

[_veh] call gradTnT_vehicleRespawn_fnc_add;
[_veh] remoteExec ["gradTnT_fnc_addExplosiveAction", 0, true];
[_veh] call gradTnT_bft_fnc_add;
[_veh] remoteExec ["gradTnT_fnc_addCamoActions", 0, true];

// flag for capturing only on non tank vehicles
[_veh] remoteExecCall ["gradTnT_flag_fnc_addTakeAction", 0, true];

_veh disableTIEquipment true;

// assign side to vehicle
if (_engineerVehicle) then {
    _veh setVariable ["gradTnT_engineerVehicle", true, true];
} else {
    _veh setVariable ["gradTnT_engineerVehicle", false, true]; // todo necessary to set respawn var even when false?
};


// default items for each vehicle
_veh addItemCargoGlobal ["ACE_EntrenchingTool", 2];
_veh addItemCargoGlobal ["ACE_bloodIV", 30];
_veh addItemCargoGlobal ["ACE_fieldDressing", 30];
_veh addItemCargoGlobal ["ACE_epinephrine", 20];
_veh addItemCargoGlobal ["ACE_morphine", 20];
_veh addItemCargoGlobal ["ACE_tourniquet", 10];

if (typeOf _veh in [
    "gm_gc_army_btr60pb",
    "gm_gc_army_bmp1sp2"]
    ) then {
    _veh addItemCargoGlobal ["gm_minestatic_at_tm46", 10];
};

if (typeOf _veh in [
    "gm_ge_army_luchsa2",
    "gm_ge_army_marder1a2"]
    ) then {
    _veh addItemCargoGlobal ["gm_minestatic_at_dm21", 10];
};
