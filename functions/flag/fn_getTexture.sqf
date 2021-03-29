/*
 * Name: gradTnT_flag_fnc_getTexture
 * Author: nomisum
 * Get flag texture for side.
 *
 * Arguments:
 * 0: Side <SIDE>
 *
 * Return Value:
 * Flag texture for side <STRING>
 *
 * Example:
 * private _texture = [side player] call gradTnT_flag_fnc_getTexture;
 *
 * Public: No
 */
params [["_side", sideUnknown, [sideUnknown]]];

([ 
    "\gm\gm_core\data\flags\gm_flag_UR_co.paa", 
    "\gm\gm_core\data\flags\gm_flag_GE_co.paa" 
] select (_side isEqualTo west))