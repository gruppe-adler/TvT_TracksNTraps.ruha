/*
 * Name: gradTnT_flag_fnc_draw
 * Author: nomisum
 * Event handler for draw event on map controls.
 *
 * Arguments:
 * 0: Map control <CONTROL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */
params ["_control"];

private _flag = missionNamespace getVariable ["gradTnT_flagObjective", objNull];

if (isNull _flag) exitWith {};

private _owner = _flag getVariable ["gradTnT_flag_owner", sideUnknown];
private _objectiveIcon = "";

switch (_owner) do { 
    case west : {  
        _objectiveIcon = getMissionPath "functions\flag\data\ico_objective_blufor.paa";
    }; 
    case east : {
        _objectiveIcon = getMissionPath "functions\flag\data\ico_objective_opfor.paa";
    }; 
    case sideUnknown : {
        _objectiveIcon = getMissionPath "functions\flag\data\ico_objective_neutral.paa";
    }; 
    default {  /*...code...*/ }; 
};

_control drawIcon 
[
    _objectiveIcon,
    [1,1,1,1],
    getPos _flag,
    40,
    40,
    0,
    "",
    1,
    0.03,
    "TahomaB",
    "center"
];