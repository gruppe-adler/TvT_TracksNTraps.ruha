/*
 * Name: gradTnT_flag_fnc_addControl
 * Author: nomisum
 * Setup control point.
 *
 * Arguments:
 * 0: Flag <OBJECT>
 * 1: Speakers <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, flagSpeakers] call gradTnT_flag_fnc_addControl;
 *
 * Public: No
 */
params ["_flag", "_flagSpeakers"];

if (isServer) then {
    _flag setFlagTexture "";
    _flag setVariable ["gradTnT_flagSpeakers", _flagSpeakers, true];

    missionNamespace setVariable ["gradTnT_flagObjective", _flag, true];

    // count points
    [{
        params ["_args", "_handle"];
        _args params ["_flag"];

        private _flagOwner = _flag getVariable ["gradTnT_flagOwner", sideUnknown];
        ["gradTnT_points", ["flagTick", _flagOwner]] call CBA_fnc_serverEvent;

    }, 60, [_flag]] call CBA_fnc_addPerFrameHandler;
};
