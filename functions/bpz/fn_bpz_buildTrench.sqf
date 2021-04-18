if (!isServer) exitWith {};

// global vars
gradTnT_vehicleTrenchClass = "GRAD_envelope_vehicle";
gradTnT_vehicleTrench_posOffset = 2;
gradTnT_vehicleTrench_vehicleCenterToGround = 2.5;
gradTnT_vehicleTrench_ammoThatDestroys =
[
  "gm_missile_hot_heat_dm102",
  "gm_missile_hot_heat_dm72",
  "gm_missile_milan_heat_dm92",
  "gm_missile_bastion_heat_9M117",
  "gm_missile_bastion_heat_9M117M",
  "gm_missile_bastion_heat_9M117M1",
  "gm_missile_milan_heat_dm82",
  "gm_rocket_84x245mm_HEAT_T_DM32",
  "gm_rocket_40mm_HEAT_pg7vl",
  "gm_missile_maljutka_heat_9m14m",
  "gm_missile_fagot_heat_9m111",
  "gm_rocket_84x245mm_HEAT_T_DM22",
  "gm_rocket_84x245mm_HEAT_T_DM12A1",
  "gm_missile_maljutka_heat_9m14",
  "gm_rocket_44x537mm_HEAT_dm32",
  "gm_rocket_84x245mm_HEAT_T_DM12",
  "gm_rocket_40mm_HEAT_pg7v",
  "gm_rocket_55mm_heat_s5k",
  "gm_shell_100x695mm_he_of412",
  "gm_shell_76x385mm_HEAT_T_bk350m",
  "gm_shell_76x385mm_he_of350",
  "gm_shell_73mm_heat_pg15v",
  "gm_shell_73mm_he_og15v",
  "gm_rocket_55mm_HE_s5",
  "gm_bullet_20x139mm_he_t_dm51",
  "gm_shell_105x617mm_heat_mp_t_dm12",
  "gm_shell_100x695mm_heat_t_bk5m",
  "gm_bullet_23x115mm_hei_ofz",
  "gm_bullet_23x152mm_hei_ofz",
  "gm_bullet_145x114mm_HEI_T_MDZ",
  "gm_bullet_20x139mm_hei_t_dm81",
  "gm_bullet_20x139mm_hei_t_dm111",
  "gm_bullet_23x115mm_hei_t_ofzt",
  "gm_bullet_23x152mm_hei_t_ofzt",
  "gm_bullet_23x152mm_hei_t_ofzt",
  "gm_bullet_25x137mm_hei_t_M792",
  "gm_bullet_35x228mm_hei_t_DM21",
  "gm_shell_76x385mm_HVAP_T_br354p",
  "gm_bullet_35x228mm_hvapds_t_DM23"
];

gradTnT_vehicleTrench_subMunitionThatDestroys = [];

{
    gradTnT_vehicleTrench_subMunitionThatDestroys pushBackUnique (getText (configFile >> "CfgAmmo" >> _x >> "submunitionAmmo"));
} forEach gradTnT_vehicleTrench_ammoThatDestroys;



params ["_vehicle"];


gradTnT_fnc_createBuildUp = {
  params ["_vehicle", ["_scale", 0.2]];

  systemChat "build up started";
  _vehicle setVariable ["gradTnT_bpz_trenchAttachedScale", _scale, true];
  [_vehicle, _scale] remoteExec ["gradTnT_fnc_bpz_buildTrenchLocal", 0];
  
};


gradTnT_fnc_buildUpOnVehicle = {
    params ["_vehicle"];

    private _speedLimit = 15;
    private _speed = speed _vehicle;
    if (_speed > _speedLimit) then {
      _vehicle setVelocity ((velocity _vehicle) vectorMultiply ((_speedLimit / _speed) - 0.00001));
    };

    // dont dig on roads, concrete etc
    if (!([_vehicle] call ace_common_fnc_canDig)) exitWith {
      // systemChat "cant dig";
    };
    
    private _scale = _vehicle getVariable ["gradTnT_bpz_trenchAttachedScale", -1];
    if (_scale < 0) exitWith {
        [_vehicle, 0.1] call gradTnT_fnc_createBuildUp;
        _vehicle setVariable ["gradTnT_bpz_trenchAttachedScale", 0.1, true];
    };
    
    private _buildUpSpeed = 0.001 * 1/_scale; // step of size change
    private _maxScale = 1; // maximum scale when starting from scratch
    if (_scale < _maxScale) then {
        _scale = _scale + _buildUpSpeed;
        _vehicle setVariable ["gradTnT_bpz_trenchAttachedScale", _scale, true];
    };    
};

gradTnT_fnc_dropBuildUp = {
    params ["_vehicle"];   

    // exit trench mode when reversing
    _vehicle setVariable ['gradTnT_trenchMode', false, true];
    _vehicle animateSource ["dozer_blade_elev_source", 0];


    private _scale = _vehicle getVariable ["gradTnT_bpz_trenchAttachedScale", -1];
    if (_scale < 0) exitWith {
        diag_log format ["no trench attached"];
    };

    // clear condition for drop
    _vehicle setVariable ["gradTnT_bpz_trenchAttachedScale", -1, true];

    // get local trench from server and replace it with a global one
    private _trenchAttachedServer = _vehicle getVariable ["gradTnT_bpz_trenchAttachedLocal", objNull];
    private _position = getPosATLVisual _trenchAttachedServer;

    // todo make sure no instaplosion
     private _trenchDropped = createVehicle [gradTnT_vehicleTrenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
    _trenchDropped setObjectTextureGlobal [0, surfaceTexture (position _vehicle)];
    _trenchDropped setDir (getDir _vehicle);
    _trenchDropped setPosATL _position;
    _trenchDropped setVariable ["gradTnT_trenchScale", _scale];

    deleteVehicle _trenchAttachedServer;

    [_trenchDropped] call gradTnT_fnc_addHitHandler;
};

_vehicle addEventHandler ["EpeContactStart", {
    params ["_object1", "_object2", "_selection1", "_selection2", "_force"];

    if (!(_object1 getVariable ["gradTnT_trenchMode", false])) exitWith {};

    if (typeOf _object2 == gradTnT_vehicleTrenchClass) then {
        private _scale1 = _object1 getVariable ["gradTnT_bpz_trenchAttachedScale", -1];
        private _currentScaleAttached = if (_scale1 > 0) then { _scale1 } else { 0 };
        private _scale = _object2 getVariable ["gradTnT_trenchScale", 0.1];
        private _scaleCombined = (_scale + _currentScaleAttached) min 1;

        if (_scale1 > 0) then {
            _object1 setVariable ["gradTnT_bpz_trenchAttachedScale", _scaleCombined, true];
            deleteVehicle _object2;
        } else {
            [_object1, _scaleCombined] call gradTnT_fnc_createBuildUp;
            deleteVehicle _object2;
        };
    };
}];

gradTnT_fnc_addHitHandler = {
    params ["_trench"];

    if (_trench getVariable ["gradTnT_hitHandler", false]) exitWith {
        diag_log format ["not adding hit handler, already there"];
    };

    _trench setVariable ["gradTnT_hitHandler", true, true];

    _trench addEventHandler ["HitPart", {
        (_this select 0) params ["_vehicle", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];


      if (_isDirect) then {
        private _type = _ammo select 4;
        diag_log format ["direct Hit with " + str _ammo];

          if (_type in gradTnT_vehicleTrench_subMunitionThatDestroys) then {
              // send fx to clients
              [_target, ASLToAGL _position] remoteExec ["gradTnT_fnc_bpz_buildTrench_destroyParticle", [0,-2] select isDedicated];

              private _scale = _target getVariable ["gradTnT_trenchScale", 0.1];
              if (_scale > 0.5) then {
                  private _newScale = _scale/1.5;
                  _target setVariable ["gradTnT_trenchScale", _newScale];
                  private _position = getPos _target;
                  _position set [2, -gradTnT_vehicleTrench_vehicleCenterToGround-(gradTnT_vehicleTrench_posOffset*_newScale)];
                  _target setPos _position;
              } else {
                  deleteVehicle _target;
              };
          };
        };
    }];
};


[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (!alive _vehicle) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
    if (!(_vehicle getVariable ["gradTnT_trenchMode", false])) exitWith {};
    if (isNull driver _vehicle) exitWith {};

    private _speed = velocityModelSpace _vehicle select 1;

    if (_speed > 1) then { 
        [_vehicle] call gradTnT_fnc_buildUpOnVehicle;
    };
    if (_speed < -0.5) then {
      // systemChat ("reversing "+ str _speed);
        if (_vehicle getVariable ["gradTnT_bpz_trenchAttachedScale", -1] > 0) then {
            [_vehicle] call gradTnT_fnc_dropBuildUp;
            // systemChat ("dropping");
        };
    };

}, 0.5, [_vehicle]] call CBA_fnc_addPerFrameHandler;
