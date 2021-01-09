["gradTnT_vehicleRespawn", {
	params ["_veh"];

	[_veh] spawn gradTnT_fnc_initVehicle;
    [_veh] spawn gradTnT_fnc_bftAdd;
    
	[_veh] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
}] call CBA_fnc_addEventHandler;