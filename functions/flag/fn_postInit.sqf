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

if (hasInterface) then {
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
};


// server manages conquering
if (isServer) then {
    private _flag = missionNamespace getVariable ["gradTnT_flagObjective", objNull];
    private _trigger = trg_objective;
    [
        {
            params ["_args", "_handle"];

            _args call gradTnt_flag_fnc_tick;
        },
        1,
        [_flag, _trigger]
    ] call CBA_fnc_addPerFrameHandler;
};