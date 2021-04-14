/*
    
    grad_trenches dependency!

*/

params ["_bpz", "_trenchClass"];

// private _pos = getPos _bpz;
_bpz animateSource ["dozer_blade_elev_source", 1];

//Get the placement data and other important values from the preview trench
private _posOffset = 2;
private _modelHeight = 3;
private _posEnd = _bpz modelToWorld [1,3,-_posOffset];
private _positionZero = _bpz modelToWorld [1,3, -_posOffset -_modelHeight];
private _posDiff = (_posEnd select 2) - (_positionZero select 2);
private _vecDirAndUp = [(vectorDir _bpz), (vectorUp _bpz)];

//Create a new trench, that is globaly visible
private _trench = createVehicle [_trenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
private _digTime = 5;

_trench setPos _positionZero;
systemChat str _positionZero;
_trench setObjectTextureGlobal [0, surfaceTexture _posEnd];

_trench setVariable ["grad_trenches_endPos", _posEnd, true];
_trench setVariable ["grad_trenches_diggingSteps", (_posDiff/(_digTime*10)), true];
_trench setVectorDirAndUp _vecDirAndUp;

_trench setVariable ["ace_trenches_placeData", [_posEnd, _vecDirAndUp], true];
_trench setVariable ["ace_trenches_progress", 0, true];

_trench setVariable ["grad_trenches_diggers",[_bpz], true];
_trench setVariable ["ace_trenches_digging", true, true];

[{
    params ["_args", "_handle"];
    _args params ["_trench", "_unit", "_digTime", "_vecDirAndUp", "_positionZero", "_posEnd", "_posDiff"];
    
    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
    _positionZero params ["", "", "_posZeroZ"];   

    if (
        !(_trench getVariable ["ace_trenches_digging", false])
    ) exitWith {
        systemChat (str (_trench getVariable ["ace_trenches_digging", false]));
        [_handle] call CBA_fnc_removePerFrameHandler;
        _trench setVariable ["ace_trenches_digging", false, true];
        _trench setVariable ["grad_trenches_diggers",[], true];
        _unit animateSource ["dozer_blade_elev_source", 0];
    };

    if (_actualProgress >= 1) exitWith {
        systemChat "completed";
        [_handle] call CBA_fnc_removePerFrameHandler;
        _trench setVariable ["grad_trenches_diggers",[], true];
        _trench setVariable ["ace_trenches_digging", false, true];
        _unit animateSource ["dozer_blade_elev_source", 0];
    };

    if (_unit animationSourcePhase "dozer_blade_elev_source" == 1) then {
        _unit animateSource ["dozer_blade_elev_source", 0];
        _unit setVariable ["gradTnT_bpzBladeAnimation", true];
    };
    if (_unit animationSourcePhase "dozer_blade_elev_source" < 0.7) then {
        _unit animateSource ["dozer_blade_elev_source", 1];
        _unit setVariable ["gradTnT_bpzBladeAnimation", false];
    };

    if (_unit getVariable ["gradTnT_bpzBladeAnimation", false]) then {
        private _posZFinal = _posZeroZ + (_posDiff * _actualProgress);
        // systemChat (str (_posDiff * _actualProgress) + " " + str _posZeroZ + " " + str (_posZFinal) + "  " + str _actualProgress);

        _posEnd set [2, _posZFinal];
        _trench setPos _posEnd;
        _trench setVectorDirAndUp _vecDirAndUp;

        _trench setVariable ["ace_trenches_progress", _actualProgress + ((1/_digTime)/10), true];
    };

}, 0.1, [_trench, _bpz, _digTime, _vecDirAndUp, _positionZero, _posEnd, _posDiff]] call CBA_fnc_addPerFrameHandler;