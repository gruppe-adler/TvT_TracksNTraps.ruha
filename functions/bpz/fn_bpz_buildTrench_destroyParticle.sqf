params ["_vehicle", "_position"];

private _vector = (vectorDir _vehicle) vectorMultiply 1;
private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
_ps1 setPos _position;
_ps1 setParticleParams [   
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
 1, 10, [0,0,0], _vector, 1, 10, 1, 0.2, [0.1, 0.1],   
 [[1, 1, 1 ,1]],   
 [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
_ps1 setParticleRandom [2, [4, 4, 4], [2, 2, 4], 0, 1, [0, 0, 0, 0], 0, 0];
_ps1 setDropInterval 0.001;  
[{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute; 