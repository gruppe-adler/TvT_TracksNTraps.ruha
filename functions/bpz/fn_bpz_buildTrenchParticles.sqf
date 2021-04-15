
private _vector = (vectorDir vehicle player) vectorMultiply 10;
private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
_ps1 attachTo [vehicle player, [0,4,0]];
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
 1, 10, [0,0,-3], _vector, 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [1.5, 0.1, 1], [2, 2, 3], 0, 1, [0, 0, 0, 0], 0, 0];   
_ps1 setDropInterval 0.04;  
[{ deleteVehicle (_this select 0); }, [_ps1], 10] call CBA_fnc_waitAndExecute; 





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