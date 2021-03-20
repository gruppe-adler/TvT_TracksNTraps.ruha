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
    private _ropes = [];
    private _hooks = (nearestObjects [player, ["gm_bpz2a1_hook"], 30]);
    private _vehicle = objNull;

    if (count _hooks > 0) then {
        _hooks params ["_hook"];
        if (_hook getVariable ["canHook", false]) then {
            _ropes = _hook getVariable ["gradTnT_bpz_ropesHook", []];
            _vehicle = _hook getVariable ["gradTnT_bpz_hookVehicle", objNull];
        };
    };

    [_ropes, _hook, _vehicle]
};


gradTnT_fnc_bpz_pickupAction = {
    params ["_player"];
    private _nearByRopes = call gradTnT_fnc_bpz_findNearbyFreeRopes;
    
    [_nearByRopes, _player] call gradTnT_fnc_bpz_pickupRopes;  
};



[{
    params ["_args", "_handle"];

    private _nearByRopes = call gradTnT_fnc_bpz_findNearbyFreeRopes;
    missionNamespace setVariable ["gradTnT_nearByRopes",_nearByRopes];

}, 2, []] call CBA_fnc_addPerFrameHandler;


player addAction ["Pickup Cargo Ropes", { 
    [player] call gradTnT_fnc_bpz_pickupAction;
}, nil, 0, false, true, "", "call gradTnT_fnc_bpz_canPickUpRopes"];