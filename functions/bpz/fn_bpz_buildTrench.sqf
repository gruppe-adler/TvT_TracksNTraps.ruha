/*
    
    grad_trenches dependency!

*/

params ["_bpz", "_trenchClass"];

// private _pos = getPos _bpz;
_bpz animateSource ["dozer_blade_elev_source", 1];

//Get the placement data and other important values from the preview trench
private _posDiff = 
    ([configFile >> "CfgVehicles" >> _trenchClass >> "grad_trenches_offset", "NUMBER", 2] call CBA_fnc_getConfigEntry)
    + ((sizeOf typeOf _bpz)/2);
private _pos = _bpz modelToWorldWorld [0,0,0];
private _newPos = _bpz modelToWorldWorld [0,0, -(_posDiff)];
private _vecDirAndUp = [(vectorDir _bpz), (vectorUp _bpz)];

//Create a new trench, that is globaly visible
private _trench = createVehicle [_trenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
private _digTime = 5;

_trench setPosWorld _newPos;
_trench setObjectTextureGlobal [0, surfaceTexture _pos];

_trench setVariable ["grad_trenches_endPos", _pos, true];
_trench setVariable ["grad_trenches_diggingSteps", (_posDiff/(_digTime*10)), true];
_trench setVectorDirAndUp _vecDirAndUp;

_trench setVariable ["ace_trenches_placeData", [_pos, _vecDirAndUp], true];
_trench setVariable ["ace_trenches_progress", 0, true];

_trench setVariable ["grad_trenches_diggers",[_bpz], true];
_trench setVariable ["ace_trenches_digging", true, true];

[{
    params ["_args", "_handle"];
    _args params ["_trench", "_unit", "_digTime", "_vecDirAndUp"];
    
    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
    private _diggerCount = count (_trench getVariable ["grad_trenches_diggers",[]]);

    systemChat str (getPos _Trench);

    if (
        !(_trench getVariable ["ace_trenches_digging", false]) ||
        {_diggerCount <= 0}
    ) exitWith {
        systemChat (str _diggerCount + str (_trench getVariable ["ace_trenches_digging", false]));
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
    };
    if (_unit animationSourcePhase "dozer_blade_elev_source" == 0) then {
        _unit animateSource ["dozer_blade_elev_source", 1];
    };

    private _pos = (getPosWorld _trench);
    private _posDiff = 
        (_trench getVariable ["grad_trenches_diggingSteps", (([configFile >> "CfgVehicles" >> typeOf _trench >> "grad_trenches_offset", "NUMBER", 2] call CBA_fnc_getConfigEntry)/(_digTime*10))]) * _diggerCount;
 
    _pos set [2, ((_pos select 2) + _posDiff)];
    _trench setPosWorld _pos;
    _trench setVectorDirAndUp _vecDirAndUp;

    _trench setVariable ["ace_trenches_progress", _actualProgress + ((1/_digTime)/10) * _diggerCount, true];

}, 0.1, [_trench, _bpz, _digTime, _vecDirAndUp]] call CBA_fnc_addPerFrameHandler;