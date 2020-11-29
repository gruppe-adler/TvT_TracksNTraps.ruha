if (!(isServer)) exitWith {};

params ["_veh", "_respawnWhenNotDead", "_gmAttributes"];

private _type = typeOf _veh;

clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

_veh setVariable ["gm_vehicle_attributes", _gmAttributes];
[_veh] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;

// add check loop for this vehicle
[_veh, false] call gradSB_fnc_vehicleRespawnAdd;
