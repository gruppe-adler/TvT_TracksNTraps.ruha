if (!(isServer)) exitWith {};

params ["_veh", "_respawnWhenNotDead"];

private _type = typeOf _veh;

clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

// add check loop for this vehicle
[_veh, _respawnWhenNotDead] call gradSB_fnc_vehicleRespawnAdd;
