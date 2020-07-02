params ["_depot", ["_destroyed", false]];

private _side = _depot getVariable ["SB_depotSide", sideUnknown];

if (_destroyed) exitWith {
    private _marker = _depot getVariable ["SB_depotMarkerLocal", ""];
    _marker setMarkerTypeLocal "hd_destroy";
};

private _position = position _depot;
private _markerName = format ["mrk_depot_%1", str _position];
private _marker = createMarkerLocal [_markerName, _position];
_marker setMarkerPosLocal _position;

if (_side == west) then {
    _marker setMarkerColorLocal "ColorBlufor";
} else {
    _marker setMarkerColorLocal "ColorOpfor";
};

_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "b_maint";

_depot setVariable ["SB_depotMarkerLocal", _marker];

///// minen gehen nur auf ketten