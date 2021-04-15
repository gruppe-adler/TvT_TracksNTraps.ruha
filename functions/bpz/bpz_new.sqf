

// global vars
gradTnT_vehicleTrenchClass = "GRAD_envelope_vehicle";
gradTnT_vehicleTrench_posOffset = 2;
gradTnT_vehicleTrench_vehicleCenterToGround = 2.5;

params ["_vehicle"];

_vehicle addAction
[
    "Enter Trench Mode",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["gradTnT_trenchMode", true, true];
        _target animateSource ["dozer_blade_elev_source", 0.65];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in (crew (_target)) && speed (_target) < 1 && !(_target getVariable ['gradTnT_trenchMode', false])",
    50,
    false
];

_vehicle addAction
[
    "Exit Trench Mode",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["gradTnT_trenchMode", false, true];
        _target animateSource ["dozer_blade_elev_source", 0];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in (crew (_target)) && speed (_target) < 1 && (_target getVariable ['gradTnT_trenchMode', false])",
    50,
    false
];

gradTnT_fnc_scaleOverTime = {
    params ["_object", "_value", ["_duration",1], ["_deleteAfterScale", false]];

    // allow only one scaling at a time
    private _isScaling = _object getVariable ["gradTnT_objectIsScaling", false];
    if (_isScaling) exitWith {
        "object scaling not allowed, already scaling" call BIS_fnc_log;
    };
    _object setVariable ["gradTnT_objectIsScaling", true, true];

    private _diff = _value - getObjectScale _object;
    private _step = _diff/(_duration*10); // multiply by 10 bc 1 step is 0.1s

    [{
      params ["_args", "_handle"];
      _args params ["_object", "_value", "_step"];

      if (getObjectScale _object == _value) exitWith {
          [_handle] call CBA_fnc_removePerFrameHandler;
          _object setVariable ["gradTnT_objectIsScaling", false, true];
          "object scaling finished" call BIS_fnc_log;

          if (_deleteAfterScale) then {
              deleteVehicle _object;
          };
      };

      private _currentScale = getObjectScale _object;
      _object setObjectScale (_currentScale + _step);

    }, 0.1, [_object, _value, _step]] call CBA_fnc_addPerFrameHandler;
};

gradTnT_fnc_createBuildUp = {
  params ["_vehicle", ["_scale", 0.2]];

  private _offset = [.5,4,-gradTnT_vehicleTrench_posOffset-gradTnT_vehicleTrench_vehicleCenterToGround];

  private _trenchAttached = createVehicle [gradTnT_vehicleTrenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
  _trenchAttached setObjectTextureGlobal [0, surfaceTexture position _vehicle];
  _trenchAttached attachTo [_vehicle, _offset];
  _trenchAttached setObjectScale _scale;

  _vehicle setVariable ["gradTnT_bpz_trenchAttached", _trenchAttached];

  _trenchAttached
};


gradTnT_fnc_buildUpOnVehicle = {
    params ["_vehicle"];

    // dont dig on roads, concrete etc
    if (!([_vehicle] call ace_common_fnc_canDig)) exitWith {
      systemChat "cant dig";
    };

    private _buildUpSpeed = 0.001; // step of size change
    private _maxScale = 1; // maximum scale when starting from scratch
    private _trenchAttached = _vehicle getVariable ["gradTnT_bpz_trenchAttached", objNull];
    if (isNull _trenchAttached) then {
        _trenchAttached = [_vehicle, 0.1] call gradTnT_fnc_createBuildUp;
    };

    private _scale = getObjectScale _trenchAttached;

    // systemChat ("object is " + str _trenchAttached + "   scale is " + str _scale);
    if (_scale < _maxScale) then {
        _scale = _scale + _buildUpSpeed;
    };
    _trenchAttached setObjectScale _scale;
};

gradTnT_fnc_dropBuildUp = {
    params ["_vehicle"];

    private _trenchAttached = _vehicle getVariable ["gradTnT_bpz_trenchAttached", objNull];
    if (isNull _trenchAttached) exitWith {
        systemChat "no trench attached";
    };

    private _scale = getObjectScale _trenchAttached;
    
    // todo make sure no instaplosion
     private _trenchDropped = createVehicle [gradTnT_vehicleTrenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
     private _position = _vehicle modelToWorld [.5,5,-gradTnT_vehicleTrench_posOffset];
    _trenchDropped setObjectTextureGlobal [0, surfaceTexture (position _vehicle)];
    _trenchDropped setObjectScale _scale;
    _trenchDropped setDir (getDir _vehicle);
    _trenchDropped setPos _position;

    deleteVehicle _trenchAttached;
};

_vehicle addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force"];

  
  if (typeOf _object2 == gradTnT_vehicleTrenchClass) then {
    private _trenchAttached = _object1 getVariable ["gradTnT_bpz_trenchAttached", objNull];
    private _currentScaleAttached = if (!isNull _trenchAttached) then { getObjectScale _trenchAttached } else { 0 };
    private _scale = getObjectScale _object2;
    private _scaleCombined = (_scale + _currentScaleAttached) min 1;

    if (!isNull _trenchAttached) then {
        _trenchAttached setObjectScale _scaleCombined;
        private _offset = [.5,4,-gradTnT_vehicleTrench_posOffset-gradTnT_vehicleTrench_vehicleCenterToGround];
        _trenchAttached attachTo [_vehicle, _offset];
        deleteVehicle _object2;
    } else {
        [_object1, _scaleCombined] call gradTnT_fnc_createBuildUp;
        deleteVehicle _object2;
    };
  };
}];


[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (!alive _vehicle) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
    if (!(_vehicle getVariable ["gradTnT_trenchMode", false])) exitWith {};

    private _speed = velocityModelSpace _vehicle select 1;

    if (_speed > 1) then { 
      [_vehicle] call gradTnT_fnc_buildUpOnVehicle; 
    };
    if (_speed < -0.5) then {
      // systemChat ("reversing "+ str _speed);
        if (!(isNull (_vehicle getVariable ["gradTnT_bpz_trenchAttached", objNull]))) then {
            [_vehicle] call gradTnT_fnc_dropBuildUp;
            // systemChat ("dropping");
        };
    };

}, 0, [_vehicle]] call CBA_fnc_addPerFrameHandler;
