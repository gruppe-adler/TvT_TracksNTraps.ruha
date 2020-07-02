/*
    
    execVM "markRivers.sqf";

*/


private _riverObjects =
[
    "gm_river_01_600.p3d",
    "gm_river_01_600_r1.p3d"
];

private _rivers = nearestTerrainObjects [[worldSize/2, worldSize/2], [], worldSize];

systemChat "detecting rivers";

{
    private _riverObject = _x;
    (getModelInfo _riverObject) params ["_modelName"];

    if ((_riverObjects find _modelName) < 0) exitWith {};


    private _position = position _riverObject;
    diag_log str _position;

    private _markerName = format ["mrk_river_%1", str _position];
    _markerstr = createMarkerLocal [_markerName, _position];
    _markerstr setMarkerShapeLocal "ICON";
    _markerstr setMarkerTypeLocal "DOT";
    _markerstr setMarkerColorLocal "ColorBlue";
    sleep 0.01;
} forEach _rivers;