
private _vector = (vectorDir vehicle player) vectorMultiply 1;
private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
_ps1 attachTo [vehicle player, [0,3,0]];
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
 1, 10, [0,1,-2.5], _vector, 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [1.5, 0.1, 2], [2, 2, 4], 0, 1, [0, 0, 0, 0], 0, 0];   
_ps1 setParticleCircle [3.2, [1,-1,2]];
_ps1 setDropInterval 0.005;  
[{ deleteVehicle (_this select 0); }, [_ps1], 10] call CBA_fnc_waitAndExecute; 

grad_weight = 10; 
grad_volume = 8; 
grad_rubbing = 0.001; 
grad_intensity = 5; 
grad_transparency = 1; 
grad_colorR = 0.15; 
grad_colorG = 0.10; 
grad_colorB = 0.05; 
grad_bounce = 1;
grad_uplift = 1.05; 
private _grad_dust = "#particlesource" createVehicleLocal [0,0,0]; 
_grad_dust attachTo [vehicle player, [0,3,0]];
_grad_dust setParticleParams [
        ["\A3\data_f\cl_basic", 1, 0, 1],
         "", "Billboard", 1, 1, 
         [0, 0, 0], 
         [0, 0, grad_uplift], 0.3, 
         grad_weight,
         grad_volume,
         grad_rubbing,
         [1, 1.5, 2, 3, 4], 
         [
            [0, 0, 0, 0],
            [grad_colorR, grad_colorG, grad_colorB, 0.1],
            [grad_colorR, grad_colorG, grad_colorB, 0.2],
            [grad_colorR, grad_colorG, grad_colorB, 0.2],
            [grad_colorR, grad_colorG, grad_colorB, 0]
         ], 
         [0.08], 0, 0, "", "", _grad_dust, 0, true, grad_bounce];

_grad_dust setParticleCircle [3.2, [0,0,0]];
_grad_dust setDropInterval 0.01;

[{ deleteVehicle (_this select 0); }, [_grad_dust], 10] call CBA_fnc_waitAndExecute; 

private _posATL = vehicle player modelToWorld [0,4,0];   
_posATL set [2,0];
private _ps1 = "#particlesource" createVehicleLocal _posATL;   
_ps1 attachTo [vehicle player, [0,4,0]];
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\StoneSmall", "", "SpaceObject",   
 1, 10, vectorDir vehicle player, [0, 0, 1], 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [1.5, 0.1, 0.1], [0.25, 0.25, 3], 0, 1, [0, 0, 0, 0], 0, 0];   
_ps1 setDropInterval 0.04;  
[{ deleteVehicle (_this select 0); }, [_ps1], 10] call CBA_fnc_waitAndExecute; 