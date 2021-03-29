params ["_control"];

private _flag = missionNamespace getVariable ["gradTnT_flagObjective", objNull];

if (isNull _flag) exitWith {};

private _owner = _flag getVariable ["gradTnT_flagOwner", sideUnknown];
private _objectiveIcon = "";

switch (_owner) do { 
    case west : {  
        _objectiveIcon = getMissionPath "functions\flagControl\data\ico_objective_blufor.paa";
    }; 
    case east : {
        _objectiveIcon = getMissionPath "functions\flagControl\data\ico_objective_opfor.paa";
    }; 
    case sideUnknown : {
        _objectiveIcon = getMissionPath "functions\flagControl\data\ico_objective_neutral.paa";
    }; 
    default {  /*...code...*/ }; 
};


// vehicle icon
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