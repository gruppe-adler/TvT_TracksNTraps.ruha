/**
 * Registers vehicle respawn event handler, which adds points to enemy team
 */
if (!isServer) exitWith {};

["gradTnT_vehicleRespawn", {
    params ["_veh", "_variables"];

	private _rootClasses = [
		["gm_tracked_Tank_base", "tank"],
		["gm_wheeled_APC_base", "apc"],
		["gm_wheeled_truck_base", "car"],
		["gm_wheeled_car_base", "car"],
		["gm_helicopter_base", "heli"]
	];

	private _rootClass = "";

	{
		_x params ["_class", "_string"];
		if (_veh isKindOf _class) exitWith {
			_rootClass = _string;
		};
	} forEach _rootClasses;

	if (_rootClass isEqualTo "") exitWith {};

	// give points to opposing side of respawning vehicle
	private _side = [_veh] call gradTnT_fnc_side;
	private _sidePointsAddedTo = sideUnknown;
	switch (_side) do { 
		case west : {  _sidePointsAddedTo = east; }; 
		case east : {  _sidePointsAddedTo = west; }; 
		default {}; 
	};

	if (_sidePointsAddedTo isEqualTo sideUnknown) exitWith {};

	["gradTnT_points", [_rootClass, _sidePointsAddedTo]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;