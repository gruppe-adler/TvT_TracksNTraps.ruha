params ["_position"];

private _driverGroup = group driver vehicle player;

for "_i" from count waypoints _driverGroup - 1 to 0 step -1 do
{
    deleteWaypoint [_driverGroup, _i];
};

_wp = _driverGroup addWaypoint [_position, 0];
_driverGroup setSpeedMode "NORMAL";

call grad_publicTransport_fnc_taxiDialogClose;

vehicle player lockCargo [vehicle player getCargoIndex player, true];

_wp setWaypointStatements ["true", "
    vehicle this vehicleChat format ['Wanna get out man?!'];
    vehicle player lockCargo [vehicle player getCargoIndex player, false];
"];


// remove old marker
private _oldMarker = vehicle player getVariable ["gradTnT_taxiMarker", ""];
if (_oldMarker != "") then {
    deleteMarker _oldMarker;
};

// mark on map

private _markerId = format ["gradTnT_taxiWP_%1_%2", _position, time];
private _marker = createMarker [_markerId, _position, 1]; // Not visible yet.
_marker setMarkerType "hd_pickup";
_marker setMarkerColor ([side player,  true] call BIS_fnc_sideColor);
_marker setMarkerText (format ["Drop Off %1", groupID group player]);

vehicle player setVariable ["gradTnT_taxiMarker", _marker, true];

vehicle player vehicleChat format ['Moving to destination.'];
vehicle player lockCargo [vehicle player getCargoIndex player, true];