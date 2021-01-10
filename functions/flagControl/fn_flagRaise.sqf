params ["_flag", "_unit"];

_flag setVariable ["gradTnT_flagAnimation", true, true];

// lower flag
if (_flag getVariable ["gradTnT_flagOwner", sideUnknown] == sideUnknown) then {
    [_flag, 0, true] call BIS_fnc_animateFlag;
};

if (flagAnimationPhase _flag != 0) then {
    [_flag, 0, 0.25] call BIS_fnc_animateFlag;
};


[{
    params ["_flag"];
    flagAnimationPhase _flag == 0
},{
    params ["_flag", "_unit"];

    // delete running sounds if necessary
    private _helper = _flag getVariable ["gradTnT_flagHelper", objNull];
    if (!(isNull _helper)) then { deleteVehicle _helper; };

    _flag setFlagTexture ([_unit] call gradTnT_fnc_flagGetTexture);

    private _speakersPos = getPos (_flag getVariable ["gradTnT_flagSpeakers", objNull]);
    _speakersPos set [2,3];

    _helper = "Sign_Sphere25cm_Geometry_F" createVehicle [0,0,0];
    _helper setPos _speakersPos;
    _helper setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];
    _helper say3D ([
            "anthem_su",
            "anthem_ger"
    ] select (side _unit == west));

    _flag setVariable ["gradTnT_flagHelper", _helper, true];

    [{
        params ["_args", "_handle"];
        _args params ["_flag", "_unit", "_helper"];        

        // if player is still in reach, capture
        if (_unit distance _flag < 5) then {
            _unit setVariable ["gradTnT_flagRaising", true, true];            

            [{ params ["_helper"]; if (!(isNull _helper)) then { deleteVehicle _helper; }}, [_helper], 80] call CBA_fnc_waitAndExecute;

            if (flagAnimationPhase _flag < 1) then {
                [_flag, ((flagAnimationPhase _flag) + 0.05)] call BIS_fnc_animateFlag;
                [_unit, "ace_gestures_engageStandLowered"] call ace_common_fnc_doGesture;
            } else {
                [_handle] call CBA_fnc_removePerFrameHandler;

                private _side = side _unit;
                _flag setVariable ["gradTnT_flagAnimation", false, true];
                _flag setVariable ["gradTnT_flagOwner", _side, true];
                _unit setVariable ["gradTnT_flagRaising", false, true];

                ["gradTnT_objectiveCaptured", [_side]] call CBA_fnc_globalEvent;
            };

        } else {
            if (!(isNull _helper)) then { deleteVehicle _helper; };
            hint "Aborted Capture";
            [_handle] call CBA_fnc_removePerFrameHandler;
            [_flag, 0, 0.1] call BIS_fnc_animateFlag;
            // abort capture
            _flag setVariable ["gradTnT_flagAnimation", false, true];
            _flag setVariable ["gradTnT_flagOwner", sideUnknown, true];
            _unit setVariable ["gradTnT_flagRaising", false, true];
            ["gradTnT_objectiveCaptured", [sideUnknown]] call CBA_fnc_globalEvent;

            [{
                params ["_flag"];

                flagAnimationPhase _flag == 0
            },{
                params ["_flag"];
                _flag setFlagTexture "";
            },[_flag]] call CBA_fnc_waitUntilAndExecute;
        };

    }, 1, [_flag, _unit, _helper]] call CBA_fnc_addPerFrameHandler;

}, [_flag, _unit]] call CBA_fnc_waitUntilAndExecute;