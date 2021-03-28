if (!hasInterface) exitWith {};

gradTnT_forceRespawn_vehicles = [];

if ((vehicle player) isNotEqualTo player) then {
	gradTnT_forceRespawn_vehicles pushBackUnique (vehicle player);
};

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	gradTnT_forceRespawn_vehicles pushBackUnique _vehicle;
}];
