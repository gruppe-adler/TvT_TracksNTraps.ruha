params ["_bridge", ["_destroyed", false]];

private _side = _bridge getVariable ["SB_bridgeSide", sideUnknown];

if (side player != _side) exitWith {};

if (_destroyed) exitWith {
    private _marker = _bridge getVariable ["SB_bridgeMarkerLocal", ""];
    _marker setMarkerTypeLocal "hd_destroy";
};

private _position = position _bridge;
private _markerName = format ["mrk_bridge_%1", str _position];
private _marker = createMarkerLocal [_markerName, _position];
_marker setMarkerPosLocal _position;
_marker setMarkerColorLocal "ColorYellow";

_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_box";

_bridge setVariable ["SB_bridgeMarkerLocal", _marker];

///// minen gehen nur auf ketten