params ["_vehicle"];

private _markerstr = createMarkerLocal [format ["mrk_vehicle_%1_%2",getPos _vehicle, _vehicle], getPos _vehicle];
_markerstr setMarkerShapeLocal "ICON";
_markerstr setMarkerTypeLocal "KIA";

if (side player == east) then {
    _markerstr setMarkerColorLocal "ColorOpfor";
} else {
    _markerstr setMarkerColorLocal "ColorBlufor";
};


[{
    params ["_args", "_handle"];
    _args params ["_markerstr"];

    private _alpha = markerAlpha _markerstr;

    if (_alpha > 0) then {
        _markerstr setMarkerAlphaLocal (_alpha - 0.01);
    } else {
        [_handle] call CBA_fnc_removePerFrameHandler;
        deleteMarkerLocal _markerstr;
    };
    
}, 1, [_markerstr]] call CBA_fnc_addPerFrameHandler;