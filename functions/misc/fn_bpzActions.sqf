// [cursorObject] execVM "functions\misc\fn_bpzAction.sqf";

params ["_vehicle"];


_vehicle animateSource ["crane_trav_source", 1];
_vehicle animateSource ["crane_elev_source", 0.5];

_vehicle animateSource ["crane_hook_unhide", 0];



ASL_Get_Corner_Points = {
    params ["_vehicle"];
    private ["_centerOfMass","_bbr","_p1","_p2","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];
    private ["_maxWidth","_widthOffset","_maxLength","_lengthOffset","_widthFactor","_lengthFactor","_maxHeight","_heightOffset"];
    
    // Correct width and length factor for air
    _widthFactor = 0.5;
    _lengthFactor = 0.5;
    if(_vehicle isKindOf "Air") then {
        _widthFactor = 0.3;
    };
    if(_vehicle isKindOf "Helicopter") then {
        _widthFactor = 0.2;
        _lengthFactor = 0.45;
    };
    
    _centerOfMass = getCenterOfMass _vehicle;
    _bbr = boundingBoxReal _vehicle;
    _p1 = _bbr select 0;
    _p2 = _bbr select 1;
    _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
    _widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
    _maxLength = abs ((_p2 select 1) - (_p1 select 1));
    _lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
    _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
    _heightOffset = _maxHeight/6;
    
    _rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
    _rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
    _frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
    _frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
    
    [_rearCorner,_rearCorner2,_frontCorner,_frontCorner2];
};



Connect_Ropes = 

{
    params ["_cargo", "_ropes", "_vehicle"];
    _attachmentPoints = [_cargo] call ASL_Get_Corner_Points;
                _ropeLength = (ropeLength (_ropes select 0));
                _objDistance = (_cargo distance _vehicle) + 2;
                if( _objDistance > _ropeLength ) then {
                    hint "The cargo ropes are too short. Move vehicle closer.";
                } else {        
                    // [_vehicle,_player] call ASL_Drop_Ropes;
                    [_cargo, _attachmentPoints select 0, [0,0,-1]] ropeAttachTo (_ropes select 0);
                    [_cargo, _attachmentPoints select 1, [0,0,-1]] ropeAttachTo (_ropes select 1);
                    [_cargo, _attachmentPoints select 2, [0,0,-1]] ropeAttachTo (_ropes select 2);
                    [_cargo, _attachmentPoints select 3, [0,0,-1]] ropeAttachTo (_ropes select 3);           
                };
};
        


    
        private _hook = "gm_bpz2a1_hook" createVehicle [0,0,0];
        _hook setObjectTextureGlobal [5, "\gm\gm_vehicles\gm_land\gm_tracked\gm_bpz2\gm_ge_army_bpz2\data\oli\gm_ge_army_bpz2a0_ext_01_oli_co.paa"];
        private _position = (_vehicle modelToWorld (_vehicle selectionPosition "crane_hook"));
        _hook setPos _position;
        _hook enableRopeAttach true;

        {
        private _dummyCrane = "C_Kart_01_F" createVehicle [0,0,0]; 
        _dummyCrane attachTo [cursorObject, [0,0,0], _x];  
        _dummyCrane enableRopeAttach true; 
        _dummyCrane hideObjectGlobal true;

        private _offset = [
            [-0.1,-0.1,0],
            [-0.1,0.1,0],
            [-0.1,-0.1,0],
            [0.1,0.1,0],
            [0.1,-0.1,0],
            [0.1,0.1,0]
        ] select _forEachIndex;

        if (_forEachIndex != 4) then {
            private _dummyHook = "C_Kart_01_F" createVehicle [0,0,0];
            _dummyHook attachTo [_hook, _offset];  
            _dummyHook enableRopeAttach true; 
            _dummyHook hideObjectGlobal true;


            private _rope = ropeCreate [_dummyCrane, [0,0,0], _dummyHook, [0,0,0], 2];

            private _ropes = _vehicle getVariable ["gradTnT_bpz_ropepoints", []];
            _ropes pushBackUnique [_rope, _dummyCrane, _dummyHook];
            _vehicle setVariable ["gradTnT_bpz_ropepoints", _ropes, true];
        } else {
            private _rope = ropeCreate [_dummyCrane, [0,0,0], _hook, [0.1,-0.1,0], 2];

            private _ropes = _vehicle getVariable ["gradTnT_bpz_ropepoints", []];
            _ropes pushBackUnique [_rope, _dummyCrane, _hook];
            _vehicle setVariable ["gradTnT_bpz_ropepoints", _ropes, true];
        };

       systemChat str _forEachIndex;
    } forEach [
        "rope_1_1_pos",
        "rope_1_2_pos",
        "rope_2_1_pos",
        "rope_2_2_pos",
        "rope_3_1_pos",
        "rope_3_2_pos"
    ];



{ 
    systemchat (str (ropeLength (_x select 0))); 
} forEach _ropes;


/*
[{
    params ["_vehicle"];

    (_vehicle animationPhase "crane_trav_source" == 1)
},{
    params ["_vehicle"];

    private _hook = "gm_bpz2a1_hook" createVehicle [0,0,0];
    _hook setObjectTextureGlobal [5, "\gm\gm_vehicles\gm_land\gm_tracked\gm_bpz2\gm_ge_army_bpz2\data\oli\gm_ge_army_bpz2a0_ext_01_oli_co.paa"];
    private _position = (_vehicle modelToWorld (_vehicle selectionPosition "crane_hook"));
    _hook setPos _position;

    {
        private _dummy = "C_Kart_01_F" createVehicle [0,0,0]; 
        _dummy attachTo [cursorObject, [0,0,0], _x];  
        _dummy enableRopeAttach true; 
        _dummy hideObjectGlobal true;

        private _offset = [
            [0.1,-0.2,0],
            [0.1,0,0],
            [0.1,0.2,0],
            [-0.1,-0.2,0],
            [-0.1,0,0],
            [-0.1,0.2,0]
        ] select _forEachIndex;

        private _rope = ropeCreate [_dummy, [0,0,0], 3];

        private _ropes = _vehicle getVariable ["gradTnT_bpz_ropepoints", []];
        _ropes pushBackUnique [_rope, _dummy];
        _vehicle setVariable ["gradTnT_bpz_ropepoints", _ropes, true];
    } forEach [
        "rope_1_1_pos",
        "rope_1_2_pos",
        "rope_2_1_pos",
        "rope_2_2_pos",
        "rope_3_1_pos",
        "rope_3_2_pos"
    ];


    {
       params ["_rope", "_dummy"];

       [_hook, [0,0,0], [0,0,0]] ropeAttachTo _rope; 
    } forEach _ropes;

}, [_vehicle]] call CBA_fnc_waitUntilAndExecute;

*/



/*

_vehicle animateSource ["crane_trav_source", 1];
_vehicle animateSource ["crane_elev_source", 0.5];

_vehicle animateSource ["crane_hook_unhide", 0];

[{
    params ["_vehicle"];

    (_vehicle animationPhase "crane_trav_source" == 1)
},{
    params ["_vehicle"];

    private _hook = "gm_bpz2a1_hook" createVehicle [0,0,0];
    _hook setObjectTextureGlobal [5, "\gm\gm_vehicles\gm_land\gm_tracked\gm_bpz2\gm_ge_army_bpz2\data\oli\gm_ge_army_bpz2a0_ext_01_oli_co.paa"];
    _hook setPos (_vehicle modelToWorld (_vehicle selectionPosition "crane_hook"));

   

    {
        private _dummy = "C_Kart_01_F" createVehicle [0,0,0]; 
        _dummy attachTo [cursorObject, [0,0,0], _x];  
        _dummy enableRopeAttach true; 
        _dummy hideObjectGlobal true;

        private _offset = [
            [0.1,-0.2,0],
            [0.1,0,0],
            [0.1,0.2,0],
            [-0.1,-0.2,0],
            [-0.1,0,0],
            [-0.1,0.2,0]
        ] select _forEachIndex;

         private _dummyDown = "Land_Can_Rusty_F" createVehicle [0,0,0];
        _dummyDown setPos (_vehicle modelToWorld (_vehicle selectionPosition "crane_hook"));

        _dummyDown attachTo [_hook, _offset];

        private _rope = ropeCreate [_dummy, [0,0,0], _dummyDown, [0,0,0], 1];

        private _ropes = _vehicle getVariable ["gradTnT_bpz_ropepoints", []];
        _ropes pushBackUnique [_rope, _dummy];
        _vehicle setVariable ["gradTnT_bpz_ropepoints", _ropes, true];
    } forEach [
        "rope_1_1_pos",
        "rope_1_2_pos",
        "rope_2_1_pos",
        "rope_2_2_pos",
        "rope_3_1_pos",
        "rope_3_2_pos"
    ];
}, [_vehicle]] call CBA_fnc_waitUntilAndExecute;

*/

/*
    
    private _sphere = "Sign_Sphere25cm_F" createVehicle [0,0,0]; 
    _sphere attachTo [cursorObject, [0,0,0], "rope_1_1_pos"]; 
    
    "gm_bpz2a1_hook" createVehicle [0,0,0];
    hiddenSelections[] = {"texWheel_01","tex_01","tex_02","tex_03","tex_04","tex_05","tex_06","texAirPanel_01","texAirPanel_02","tactSign_Kp","tactSign_Icon","tactSign_Btl1","tactSign_Btl2","tactSign_Btl3","LicensePlate","LicensePlate_00","LicensePlate_01","LicensePlate_02","LicensePlate_03","LicensePlate_04","LicensePlate_05","LicensePlate_06","LicensePlate_07","LicensePlate_08","LicensePlate_09","Insignia_01","Insignia_02","Insignia_formation","Insignia_unit","Insignia_cool","Insignia_recon","Insignia_hazardSign","Insignia_nation_01","Insignia_nation_02","nr_1","nr_2","nr_3","nr_4","SecondaryPlate","nothing","SecondaryPlate_01","SecondaryPlate_02","SecondaryPlate_03","SecondaryPlate_04","SecondaryPlate_05","SecondaryPlate_06","SecondaryPlate_07","SecondaryPlate_08","Insignia_recon_02","LicensePlate_10","LicensePlate_11","LicensePlate_12","LicensePlate_13","LicensePlate_14","LicensePlate_15","LicensePlate_16","LicensePlate_17","LicensePlate_18","LicensePlate_19","Insignia_flag_01","Insignia_nation_03"};
*/

/*
crane_elev_source
crane_hook_source
crane_hook_unhide
crane_rope_handler_source
crane_trav_source
dozer_blade_elev_source

beacon_01_unhide
beacon_light_unhide_source
beacon_01_org_unhide

rope_1_1_pos
rope_1_2_pos
rope_2_1_pos
rope_2_2_pos
rope_3_1_pos
rope_3_2_pos
*/