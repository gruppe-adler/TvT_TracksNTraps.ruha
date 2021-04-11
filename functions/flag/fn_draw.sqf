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

private _pathPrefix = ["flag"] call gradTnT_fnc_pathPrefix;

switch (_owner) do { 
    case west : {  
        _objectiveIcon = format ["%1\ico_objective_blufor.paa", _pathPrefix];
    }; 
    case east : {
        _objectiveIcon = format ["%1\ico_objective_opfor.paa", _pathPrefix];
    }; 
    case sideUnknown : {
        _objectiveIcon = format ["%1\ico_objective_neutral.paa", _pathPrefix];
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