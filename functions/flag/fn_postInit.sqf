/*
 * Name: gradTnT_flag_fnc_postInit
 * Author: nomisum
 * Automatically called postInit.
 * Adds CBA Event handler to show notification, when object side changes.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

["gradTnT_objectiveCaptured", {
    params ["_side"];

    switch (_side) do { 
        case west : {
            ["BluforCaptured",["Blufor captured the objective.",""]] call BIS_fnc_showNotification;
        }; 
        case east : {
            ["OpforCaptured",["Opfor captured the objective.",""]] call BIS_fnc_showNotification;
        }; 
        case sideUnknown : {
            ["NeutralCaptured",["Objective is contested.",""]] call BIS_fnc_showNotification;
        };
        default {}; 
    };
}] call CBA_fnc_addEventHandler;