addMissionEventHandler
["Map",{   
    params ["_isOpened","_isForced"];

    if (_isOpened) then {
        private _display = call gradTnT_fnc_createBar;
    };
}];
