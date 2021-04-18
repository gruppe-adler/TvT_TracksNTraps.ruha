params ["_vehicle"];

private _vector = (vectorDir _vehicle) vectorMultiply 1;
private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
_ps1 setPos (_vehicle modelToWorld [0,3,0]);
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
 1, 10, [0,1,-2.5], _vector, 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [1.5, 0.1, 2], [2, 2, 4], 0, 1, [0, 0, 0, 0], 0, 0];   
_ps1 setParticleCircle [3.2, [1,-1,2]];
_ps1 setDropInterval 0.005;  
[{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute; 

private _grad_weight = 10; 
private _grad_volume = 8; 
private _grad_rubbing = 0.001; 
private _grad_intensity = 5; 
private _grad_transparency = 1; 
private _grad_colorR = 0.15; 
private _grad_colorG = 0.10; 
private _grad_colorB = 0.05; 
private _grad_bounce = 1;
private _grad_uplift = 1.05; 
private _grad_dust = "#particlesource" createVehicleLocal [0,0,0]; 
_grad_dust setPos (_vehicle modelToWorld [0,3,0]);
_grad_dust setParticleParams [
        ["\A3\data_f\cl_basic", 1, 0, 1],
         "", "Billboard", 1, 1, 
         [0, 0, 0], 
         [0, 0, _grad_uplift], 0.3, 
         _grad_weight,
         _grad_volume,
         _grad_rubbing,
         [1, 1.5, 2, 3, 4], 
         [
            [0, 0, 0, 0],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.1],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.2],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.2],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0]
         ], 
         [0.08], 0, 0, "", "", _grad_dust, 0, true, _grad_bounce];

_grad_dust setParticleCircle [3.2, [0,0,0]];
_grad_dust setDropInterval 0.01;

[{ deleteVehicle (_this select 0); }, [_grad_dust], 0.1] call CBA_fnc_waitAndExecute; 


private _grad_weight = 10; 
private _grad_volume = 8; 
private _grad_rubbing = 0.001; 
private _grad_intensity = 5; 
private _grad_transparency = 1; 
private _grad_colorR = 0; 
private _grad_colorG = 0; 
private _grad_colorB = 0; 
private _grad_bounce = 1;
private _grad_uplift = 1.05; 
private _grad_dust = "#particlesource" createVehicleLocal [0,0,0]; 
_grad_dust setPos (_vehicle modelToWorld [0,3.5,-1.5]);
_grad_dust setParticleParams [
        ["\A3\data_f\cl_basic", 1, 0, 1],
         "", "Billboard", 1, 1, 
         [0, 0, 0], 
         [0, 0, _grad_uplift], 0.3, 
         _grad_weight,
         _grad_volume,
         _grad_rubbing,
         [0.3, .5, .7, .9, 1.2], 
         [
            [0, 0, 0, 0],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.9],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.8],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0.5],
            [_grad_colorR, _grad_colorG, _grad_colorB, 0]
         ], 
         [0.08], 0, 0, "", "", _grad_dust, 0, true, _grad_bounce];

_grad_dust setParticleRandom [2, [1.5, 0.1, .2], [0, 0, 0], 0, 1, [0, 0, 0, 0], 0, 0];   
_grad_dust setDropInterval 0.01;

[{ deleteVehicle (_this select 0); }, [_grad_dust], 0.1] call CBA_fnc_waitAndExecute;
