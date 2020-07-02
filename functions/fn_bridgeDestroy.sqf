params ["_bridge"];


hintSilent "Explosion in 30s";

[{
    params ["_bridge"];

    _emitters = [];

    _source1 = createVehicle [ "#particlesource", ( _bridge getPos [ 15, getDir _bridge ] ) vectorAdd [ 0, 0, 5 ], [], 0, "CAN_COLLIDE" ];
    _source1 setParticleClass "GrenadeExp";
    _source1 setParticleParams [
        [
            "\A3\data_f\ParticleEffects\Universal\Universal",
            16,
            0,
            32,
            0
        ],
        "",
        "Billboard",
        0.3,
        0.3,
        [ 0,0,0 ],
        [ 0,1,0 ],
        0,
        10,
        7.9,
        0.1,
        [ 0.0125 * 0.3 + 4, 0.0125 * 0.3 + 1 ],
        [ [1,1,1,-6],[1,1,1,0] ],
        [ 1 ],
        0.2,
        0.2,
        "",
        "",
        _this,
        0,
        false,
        0.6,
        [ [ 30,30,30,0 ],[ 0,0,0,0 ] ]
    ];
    _source1 setParticleRandom [
        0,
        [ 0.4,0.1,0.4 ],
        [ 0.2,0.5,0.2 ],
        90,
        0.5,
        [ 0,0,0,0 ],
        0,
        0,
        1,
        0.0
    ];
    _source1 setParticleCircle [
        0,
        [ 0,0,0 ]
    ];
    _source1 setParticleFire [1,15,0.1];
    _emitters pushBack [ _source1, 0.3 ];

    _source2 = createVehicle [ "#particlesource", ( player getPos [ 15, getDir player ] ) vectorAdd [ 0, 0, 5 ], [], 0, "CAN_COLLIDE" ];
    _source2 setParticleClass "GrenadeSmoke1";
    _source2 setParticleParams [
        [
            "\A3\data_f\ParticleEffects\Universal\Universal",
            16,
            9,
            1,
            0
        ],
        "",
        "Billboard",
        1,
        8,
        [ 0,0,0 ],
        [ 0,1.5,0 ],
        0,
        0.0522,
        0.04,
        0.24,
        [ 0.013 * 8 + 3, 0.0125 * 8 + 6, 0.013 * 8 + 8, 0.013 * 8 + 10 ],
        [ [0.7,0.7,0.7,0.36],[0.8,0.8,0.8,0.24],[0.85,0.85,0.85,0.14],[0.9,0.9,0.9,0.08],[0.9,0.9,0.9,0.04],[1,1,1,0.01] ],
        [ 1000 ],
        0.2,
        0.2,
        "",
        "",
        _this,
        0,
        false,
        0.6,
        [ [ 30,30,30,0 ],[ 0,0,0,0 ] ]
    ];
    _source2 setParticleRandom [
        2,
        [ 0.8,0.2,0.8 ],
        [ 2.5,3.5,2.5 ],
        3,
        0.4,
        [ 0,0,0,0 ],
        0.5,
        0.02,
        1,
        0.0
    ];
    _source2 setParticleCircle [
        0,
        [ 0,0,0 ]
    ];
    _source2 setDropInterval ( 0.08 );
    _emitters pushBack [ _source2, 5 ];

    _light = createVehicle [ "#lightPoint", ( _bridge getPos [ 15, getDir _bridge ] ) vectorAdd [ 0, 0, 5 ], [], 0, "CAN_COLLIDE" ];
    _light setLightAmbient [ 0,0,0 ];
    _light setLightBrightness 10;
    _light setLightColor [ 1,0.6,0.4 ];
    _light setLightIntensity 10000;
    _light setLightAttenuation [
        0,
        0,
        0,
        2.2,
        500,
        1000
    ];
    _emitters pushBack [ _light, 0.3 ];
    
    {
        _x params[ "_source", "_length" ];

        [{
            params ["_source"];
            deleteVehicle _source;
        }, [_source], _length] call CBA_fnc_waitAndExecute;
    } forEach _emitters;
    
    private _helperObject = _bridge getVariable ["gradSB_bridgeHelper", objNull];
    deleteVehicle _helperObject;
    deleteVehicle _bridge;

}, [_bridge], 30] call CBA_fnc_waitAndExecute;