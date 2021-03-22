gradTnT_fnc_bpz_canPickUpRopes = {
  !(player getVariable ["gradTnT_ropesPickedUp", false]) &&
  count (missionNamespace getVariable ["gradTnT_nearByRopes",[]] select 0) > 0 &&
  vehicle player == player
};

gradTnT_fnc_bpz_canDropRopes = {
  player getVariable ["gradTnT_ropesPickedUp", false] &&
  vehicle player == player
};

gradTnT_fnc_bpz_canAttachRopes = {
    player getVariable ["gradTnT_ropesPickedUp", false] &&
    count (nearestObjects [player, ["LandVehicle"], 5]) > 0
};



gradTnT_fnc_bpz_attachRopes = {
    private _vehicles = nearestObjects [player, ["LandVehicle"], 5];
    private _vehicle = objNull;

    if (count _vehicles > 0) then {
        _vehicle = _vehicles select 0;

        private _originVehicle = player getVariable ["gradTnT_ropesVehicle", objNull];
        private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];
        private _helper = player getVariable ["gradTnT_ropesHelper", objNull];
        private _ropes = player getVariable ["gradTnT_ropes", []];

        player setVariable ["gradTnT_ropesPickedUp", false, true];
        _hook setVariable ["canHook", true, true];

        {
            _x params ["_rope"];
            player ropeDetach _rope;
        } forEach _ropes;

        deleteVehicle _helper;

        private _corners = [_vehicle] call gradTnT_fnc_bpz_getCornerPoints;
        _vehicle setVariable ["gradTnT_originalMass", getMass _vehicle, true];
        _vehicle setMass 5000;

        _originVehicle setVariable ["gradTnT_bpz_vehicleHooked", _vehicle, true];
        {
            _x params ["_rope"];
            [_vehicle, (_corners select _forEachIndex), [0,0,-1]] ropeAttachTo _rope;
        } forEach _ropes;
    };
};

gradTnT_fnc_bpz_detachRopes = {
    private _vehicles = nearestObjects [player, ["LandVehicle"], 5];
    private _vehicle = objNull;

    if (count _vehicles > 0) then {
        _vehicle = _vehicles select 0;

        private _originVehicle = player getVariable ["gradTnT_ropesVehicle", objNull];
        private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];
        private _helper = player getVariable ["gradTnT_ropesHelper", objNull];
        private _ropes = player getVariable ["gradTnT_ropes", []];

        player setVariable ["gradTnT_ropesPickedUp", false, true];
        _hook setVariable ["canHook", true, true];

        {
            _x params ["_rope"];
            player ropeDetach _rope;
        } forEach _ropes;

        deleteVehicle _helper;

        private _corners = [_vehicle] call gradTnT_fnc_bpz_getCornerPoints;
        private _oldMass = _vehicle getVariable ["gradTnT_originalMass", 5000];
        _vehicle setMass _oldMass;
        _originVehicle setVariable ["gradTnT_bpz_vehicleHooked", objNull, true];
        {
            _x params ["_rope"];
            [_vehicle, (_corners select _forEachIndex), [0,0,-1]] ropeDetach _rope;
        } forEach _ropes;
    };
};



gradTnT_fnc_bpz_findNearbyFreeRopes = {
    private _ropes = [];
    private _hooks = (nearestObjects [player, ["gm_bpz2a1_hook"], 30]);
    private _vehicle = objNull;
    private _hook = objNull;

    if (count _hooks > 0) then {
        _hook = _hooks select 0;
        if (_hook getVariable ["canHook", false]) then {
            _vehicle = _hook getVariable ["gradTnT_bpz_hookVehicle", objNull];
            _ropes = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];
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


player addAction ["Pickup Hook Ropes", { 
    [player] call gradTnT_fnc_bpz_pickupAction;
}, nil, 0, false, true, "", "call gradTnT_fnc_bpz_canPickUpRopes"];

player addAction ["Drop Hook Ropes", { 
    [player] call gradTnT_fnc_bpz_dropRopes;
}, nil, 0, false, true, "", "call gradTnT_fnc_bpz_canDropRopes"];

player addAction ["Attach Ropes", { 
    [player] call gradTnT_fnc_bpz_attachRopes;
}, nil, 0, false, true, "", "call gradTnT_fnc_bpz_canAttachRopes"];