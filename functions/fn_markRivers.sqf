/*

    execVM "markRivers.sqf";

*/


private _terrainObjects = nearestTerrainObjects [[worldSize/2, worldSize/2], ["HIDE"], worldSize];

private _riverObjects =
[
    "gm_river_01_600.p3d",
    "gm_river_01_600_r1.p3d",
    "gm_river_01_600_r2.p3d",
    "gm_river_01_600_r3.p3d",
    "gm_river_01_600_r4.p3d",
    "gm_river_01_600_r5.p3d",
    "gm_river_01_600_l1.p3d",
    "gm_river_01_600_l2.p3d",
    "gm_river_01_600_l3.p3d",
    "gm_river_01_600_l4.p3d",
    "gm_river_01_600_l5.p3d"
];

{
    private _riverObject = _x;
    (getModelInfo _riverObject) params ["_modelName"];

    if ((_riverObjects find _modelName) > -1) then {
        private _position = position _riverObject;
        // diag_log format ["position: %1", _position];

        private _bbr = boundingBoxReal _riverObject;
        _bbr params ["_p1", "_p2"];
        _p1 params ["_p1X", "_p1Y"];
        _p2 params ["_p2X", "_p2Y"];
        private _maxWidth = abs (_p2X - _p1X);
        private _maxLength = abs (_p2Y - _p1Y);

        private _markerName = format ["mrk_river_%1", str _position];
        private _marker = createMarkerLocal [_markerName, _position];
        _marker setMarkerPosLocal _position;
        _marker setMarkerColorLocal "ColorBlue";
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerBrushLocal "SOLID";
        _marker setMarkerSizeLocal [_maxWidth, _maxLength];
        _marker setMarkerDirLocal (getDir _riverObject);
    };
} forEach _terrainObjects;


private _allRoads = [worldSize/2, worldSize/2] nearRoads worldSize;

private _bridges =
[
    "gm_euro_bridge_02_20_mainroad_half.p3d",
    "gm_euro_bridge_02_20_mainroad.p3d",
    "gm_euro_bridge_02_20_normalroad_half.p3d",
    "gm_euro_bridge_02_20_normalroad.p3d",
    "gm_euro_bridge_01_25_track.p3d",
    "gm_euro_bridge_01_25_patrolpath.p3d",
    "gm_euro_bridge_01_25_badroad.p3d",
    "gm_euro_bridge_03_50_highway.p3d",
    "gm_euro_bridge_03_50_highway_half.p3d"
];

{
    private _bridgeObject = _x;
    (getModelInfo _bridgeObject) params ["_modelName"];

    if ((_bridges find _modelName) > -1) then {
        private _position = position _bridgeObject;
        // diag_log format ["position: %1", _position];

        private _bbr = boundingBoxReal _bridgeObject;
        _bbr params ["_p1", "_p2"];
        _p1 params ["_p1X", "_p1Y"];
        _p2 params ["_p2X", "_p2Y"];
        private _maxWidth = abs (_p2X - _p1X);
        private _maxLength = abs (_p2Y - _p1Y);

        private _markerName = format ["mrk_bridge_%1", str _position];
        private _marker = createMarkerLocal [_markerName, _position];
        _marker setMarkerPosLocal _position;
        _marker setMarkerColorLocal "ColorGreen";
        _marker setMarkerTypeLocal "mil_box";
        _marker setMarkerShapeLocal "Icon";
        _marker setMarkerAlphaLocal 0.8;

        private _bridges = missionNamespace getVariable ["SB_mapBridges", []];
        _bridges pushBack [_bridgeObject, _marker];
        missionNamespace setVariable ["SB_mapBridges", _bridges, true];
    };

} forEach _allRoads;

/*
// not necessary
[{
    params ["_args", "_handle"];

    private _bridges = missionNamespace getVariable ["SB_mapBridges", []];

    {
        _x params ["_bridge", "_marker"];

        if (damage _bridge == 1) then {
            _marker setMarkerColorLocal "ColorRed";

            [{
                params ["_bridge"];
                _bridge setDamage 0;
            }, [_bridge], 10] call CBA_fnc_waitAndExecute;
        } else {
            _marker setMarkerColorLocal "ColorGreen";
        };

    } forEach _bridges;

}, 1 , []] call CBA_fnc_addPerFrameHandler;
*/
