// [cursorObject] call gradTnT_fnc_bpz_Actions;

params ["_vehicle"];

// enter recovery mode
_vehicle animateSource ["crane_trav_source", 1];
_vehicle animateSource ["crane_elev_source", 0.25];
_vehicle animateSource ["crane_hook_unhide", 0];
_vehicle animateSource ["dozer_blade_elev_source", 1];

[{
    params ["_vehicle"];

    (_vehicle animationSourcePhase "crane_trav_source" == 1)
},{
    params ["_vehicle"];
    
    [_vehicle] call gradTnT_fnc_bpz_prepareRopesCrane;

}, [_vehicle]] call CBA_fnc_waitUntilAndExecute;

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
