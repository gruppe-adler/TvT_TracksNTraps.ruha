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
    ["_veh", objNull, [objNull]]
];

// exit if this is no the server
if (!isServer) exitWith {};

if (isNull _veh) exitWith {};

clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;


private _callsign = param [1, (_veh getVariable ["gradTnT_callsign", ["A", "1"]]), [[]], [2, 3]];
[_veh, _callsign] call gradTnT_callsign_fnc_set;
[_veh] remoteExecCall ["gradTnT_callsign_fnc_addAction", 0, true];

private _side = param [2, [_veh] call gradTnT_fnc_side, [sideUnknown]];
_veh setVariable ["gradTnT_vehicleSide", _side, true];
_veh setVariable ["tf_side", str _side, true];
_veh setVariable ["tf_hasRadio", true, true];

[_veh] call gradTnT_vehicleRespawn_fnc_add;
[_veh] remoteExec ["gradTnT_fnc_addExplosiveAction", 0];
[_veh] call gradTnT_bft_fnc_add;

// flag for capturing only on non tank vehicles
[_veh] remoteExecCall ["gradTnT_flag_fnc_addTakeAction", 0, true];

_veh disableTIEquipment true;

// assign side to vehicle
if (_veh isKindOf "gm_ge_army_bpz2a0") then {
    _veh setVariable ["gradTnT_isRepairTank", true, true];
} else {
    _veh setVariable ["gradTnT_isRepairTank", false, true]; // todo necessary to set respawn var even when false?
};


// default items for each vehicle
_veh addItemCargoGlobal ["ACE_EntrenchingTool", 2];
_veh addItemCargoGlobal ["ACE_bloodIV", 30];
_veh addItemCargoGlobal ["ACE_fieldDressing", 30];
_veh addItemCargoGlobal ["ACE_epinephrine", 20];
_veh addItemCargoGlobal ["ACE_morphine", 20];
_veh addItemCargoGlobal ["ACE_tourniquet", 10];
_veh addItemCargoGlobal ["ACE_MapTools", 2];
_veh addItemCargoGlobal ["ACE_Flashlight_XL50", 2];
_veh addItemCargoGlobal ["ACE_wirecutter", 2];
_veh addItemCargoGlobal ["grad_axe", 2];
_veh addItemCargoGlobal ["ACE_DefusalKit", 2];

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



if (_side == west) then {
    _veh addItemCargoGlobal ["ACE_key_west", 2];
} else {
    _veh addItemCargoGlobal ["ACE_key_east", 2];
};