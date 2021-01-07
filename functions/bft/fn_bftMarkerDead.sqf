params ["_vehicle"];

private _markerstr = createMarkerLocal [format ["mrk_vehicle_%1_%2",getPos _vehicle, _vehicle], getPos _vehicle];
_markerstr setMarkerShapeLocal "ICON";
_markerstr setMarkerTypeLocal "KIA";
_markerstr setMarkerColorLocal ([side player, false] call BIS_fnc_sideColor);

[{
    params ["_args", "_handle"];
    _args params ["_markerstr"];

    private _alpha = markerAlpha _markerstr;

    if (_alpha > 0) then {
        _markerstr setMarkerAlphaLocal (_alpha - 0.01);
    };
    
}, 1, [_markerstr]] call CBA_fnc_addPerFrameHandler;