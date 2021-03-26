addMissionEventHandler
["Map",{   
    params ["_isOpened","_isForced"];

    if (_isOpened) then {
        execVM "functions\mapInfo\fn_createBar.sqf";
    };
}];
