params ["_vehicle", ["_scale", 0.1]];

// todo centralize
gradTnT_vehicleTrenchClass = "GRAD_envelope_vehicle";
gradTnT_vehicleTrench_posOffset = 4.5;
gradTnT_vehicleTrench_vehicleCenterToGround = 2.5;



private _hasLocalTrench = _vehicle getVariable ["gradTnT_bpz_trenchAttachedLocal", objNull];
if (!isNull _hasLocalTrench) exitWith {
    "local trench exists already" call BIS_fnc_log;
};



private _offset = [-.1,4.1,-((gradTnT_vehicleTrench_posOffset)*(1-_scale/1))-gradTnT_vehicleTrench_vehicleCenterToGround];

private _trenchAttached = gradTnT_vehicleTrenchClass createVehicleLocal [0,0,0];
_trenchAttached attachTo [_vehicle, _offset];
_trenchAttached setObjectTexture [0, surfaceTexture position _vehicle];
_vehicle setVariable ["gradTnT_bpz_trenchAttachedLocal", _trenchAttached];


[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_trenchAttached"];

    if (!alive _vehicle) exitWith { 
        [_handle] call CBA_fnc_removePerFrameHandler; deleteVehicle _trenchAttached; 
    };

    // get scale (server feeds this var)
    private _scale = _vehicle getVariable ["gradTnT_bpz_trenchAttachedScale", -1];

    if (_scale < 0) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        deleteVehicle _trenchAttached;
    };

    private _zOffset = -((gradTnT_vehicleTrench_posOffset)*(1-_scale/1))-gradTnT_vehicleTrench_vehicleCenterToGround;
    systemChat (str _zOffset + " " + str _scale);

    // update trench
    private _offset = [-.1,4.1,_zOffset];
    _trenchAttached attachTo [_vehicle, _offset];
    _trenchAttached setObjectTexture [0, surfaceTexture position _vehicle];

}, 0, [_vehicle, _trenchAttached]] call CBA_fnc_addPerFrameHandler;