params ["_vehicle"];

gradTnT_fnc_bpz_canPickUpRopes = {
  count (player getVariable ["gradTnT_ropesVehicleAttached", []]) == 0 &&
  count (missionNamespace getVariable ["gradTnT_nearby_vehicles",[]]) > 0 &&
  vehicle player == player
};


gradTnT_fnc_bpz_getClosestRope = {
    private ["_nearbyVehicles","_closestVehicle","_closestRopeIndex","_closestDistance"];
    private ["_vehicle","_activeRope","_ropes","_ends"];
    private ["_end1","_end2","_minEndDistance"];
    _nearbyVehicles = missionNamespace getVariable ["gradTnT_nearby_vehicles",[]];
    _closestVehicle = objNull;
    _closestRopeIndex = 0;
    _closestDistance = -1;
    {
        _vehicle = _x;
        {
            _activeRope = _x;
            _ropes = [_vehicle,(_activeRope select 0)] call ASL_Get_Ropes;
            {
                _ends = ropeEndPosition _x;
                if(count _ends == 2) then {
                    _end1 = _ends select 0;
                    _end2 = _ends select 1;
                    _minEndDistance = ((position player) distance _end1) min ((position player) distance _end2);
                    if(_closestDistance == -1 || _closestDistance > _minEndDistance) then {
                        _closestDistance = _minEndDistance;
                        _closestRopeIndex = (_activeRope select 0);
                        _closestVehicle = _vehicle;
                    };
                };
            } forEach _ropes;
        } forEach ([_vehicle] call ASL_Get_Active_Ropes);
    } forEach _nearbyVehicles;
    [_closestVehicle,_closestRopeIndex];
};


gradTnT_fnc_bpz_findNearbyFreeRopes = {
    private _nearRopeEnds = [];
    private _ropeEnds = (player nearObjects ["Land_Can_Rusty_F", 30]);
    {
        if (_x getVariable ["gradTnt_ropeEnd", false] && isNull attachedTo _x) then {
            // directly search for dummy object
            _nearRopeEnds append  _x;
        };
    } forEach _ropeEnds;
    
    _nearRopeEnds;
};


gradTnT_fnc_bpz_pickupAction = {
    _closestRope = [] call gradTnT_fnc_bpz_findNearbyFreeRopes;
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



[{
    params ["_args", "_handle"];

    private _nearbyVehicles = call gradTnT_fnc_bpz_findNearbyRopes;

}, 2, []] call CBA_fnc_addPerFrameHandler;


player addAction ["Pickup Cargo Ropes", { 
    [] call gradTnT_fnc_bpz_pickupAction;
}, nil, 0, false, true, "", "call gradTnT_fnc_bpz_canPickUpRopes"];