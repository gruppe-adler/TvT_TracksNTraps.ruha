params ["_unit"];

([ 
    "\gm\gm_core\data\flags\gm_flag_UR_co.paa", 
    "\gm\gm_core\data\flags\gm_flag_GE_co.paa" 
] select (side _unit == west))