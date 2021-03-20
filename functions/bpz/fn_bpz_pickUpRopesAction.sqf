params ["_vehicle"];

gradTnT_fnc_bpz_canPickUpRopes = {
  count (player getVariable ["gradTnT_ropesVehicleAttached", []]) == 0 &&
  count (missionNamespace getVariable ["gradTnT_nearbyCrane",[]]) > 0 &&
  vehicle player == player;
};

[{
    params ["_args", "_handle"];

}, 2, []] call CBA_fnc_addPerFrameHandler;


if([] call ASL_Can_Pickup_Ropes) then {
	_closestRope = [] call ASL_Get_Closest_Rope;
	if(!isNull (_closestRope select 0)) then {
		_canPickupRopes = true;
		if!(missionNamespace getVariable ["ASL_LOCKED_VEHICLES_ENABLED",false]) then {
			if( locked (_closestRope select 0) > 1 ) then {
				["Cannot pick up cargo ropes from locked vehicle",false] call ASL_Hint;
				_canPickupRopes = false;
			};
		};
		if(_canPickupRopes) then {
			[(_closestRope select 0), player, (_closestRope select 1)] call ASL_Pickup_Ropes;
		};
	};
};
