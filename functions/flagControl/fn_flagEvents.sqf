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