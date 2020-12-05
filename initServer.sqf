["gradSB_vehicleRespawn", {
	params ["_veh"];

	clearWeaponCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;

	[_veh] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
}] call CBA_fnc_addEventHandler;