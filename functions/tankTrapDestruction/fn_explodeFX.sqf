// todo

// model = "\A3\Structures_F_Enoch\Walls\Concrete\ConcreteWall_03_m_pole_F.p3d";

params ["_position"];

for "_i" from 1 to 3 do {

    private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 
    _ps1 setPos _position;
    _ps1 setParticleParams [   
     "\A3\Structures_F_Enoch\Walls\Concrete\ConcreteWall_03_m_pole_F.p3d", "", "SpaceObject",   
     60, 10, [0,0,0], [0,0,0], 1, 10, 1, 0.2, [0.4, 0.4],   
     [[1, 1, 1 ,1]],   
     [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
    _ps1 setParticleRandom [2, [0, 0, 0], [2, 2, 4], 1, 1, [0, 0, 0, 0], 0, 0];
    _ps1 setDropInterval 0.5;  
    [{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute;

};
