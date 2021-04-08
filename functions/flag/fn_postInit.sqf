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

// clients receive notifications
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


// server manages conquering
if (isServer) then {
    [{
        private _isInArea = [];
        private _sides = [];
        private _flag = missionNamespace getVariable ["gradTnT_flagObjective", objNull];

        {
          if (_x inArea trg_objective) then {
            _isInArea pushBackUnique _x;
            _sides pushBackUnique (side _x);
          };
        } forEach allPlayers;

        if (count _isInArea > 0 && count _sides < 2) then {
            private _firstPlayer = _isInArea select 0;
            if ([_flag, _firstPlayer] call gradTnT_flag_fnc_canRaise) then {
                [_flag, _firstPlayer] call gradTnT_flag_fnc_raise;
            };
        };

    }, 1, []] call CBA_fnc_addPerFrameHandler;
};