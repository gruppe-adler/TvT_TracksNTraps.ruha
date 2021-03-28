/*
 * Name: gradTnT_markRivers_fnc_calculateRivers
 * Author: DerZade
 * Executed once on server. Caluclate "grad_markRivers_rivers"
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */

#define AREA trg_gameArea
#define RIVER_OBJS [ "gm_river_01_600.p3d", "gm_river_01_600_r1.p3d", "gm_river_01_600_r2.p3d", "gm_river_01_600_r3.p3d", "gm_river_01_600_r4.p3d", "gm_river_01_600_r5.p3d", "gm_river_01_600_l1.p3d", "gm_river_01_600_l2.p3d", "gm_river_01_600_l3.p3d", "gm_river_01_600_l4.p3d", "gm_river_01_600_l5.p3d" ]
#define BRIDGE_OBJS [ "gm_euro_bridge_02_20_mainroad_half.p3d", "gm_euro_bridge_02_20_mainroad.p3d", "gm_euro_bridge_02_20_normalroad_half.p3d", "gm_euro_bridge_02_20_normalroad.p3d", "gm_euro_bridge_01_25_track.p3d", "gm_euro_bridge_01_25_patrolpath.p3d", "gm_euro_bridge_01_25_badroad.p3d", "gm_euro_bridge_03_50_highway.p3d", "gm_euro_bridge_03_50_highway_half.p3d" ]

if (!isNil "grad_markRivers_rivers") exitWith {};
if (!isServer) exitWith {};

private _calculateRiverTris = {
    params ["_obj"];

    private _bbr = boundingBoxReal _obj;
    _bbr params ["_extreme1", "_extreme2"];
    private _r1 = _extreme1;
    private _r3 = _extreme2;
    _r1 set [2, _r3 select 2];
    private _r2 = [_r1 select 0, _r3 select 1, _r3 select 2];
    private _r4 = [_r3 select 0, _r1 select 1, _r3 select 2];

    private _p1 = _obj modelToWorldVisualWorld _r1;
    private _p2 = _obj modelToWorldVisualWorld _r2;
    private _p3 = _obj modelToWorldVisualWorld _r3;
    private _p4 = _obj modelToWorldVisualWorld _r4;
    private _p4 = _obj modelToWorldVisualWorld _r4;

    private _in = [_p1, _p2, _p3, _p4] inAreaArray AREA;

    if ((count _in) isEqualTo 0) exitWith {
        [];
    };

    [_p1, _p2, _p3, _p3, _p4, _p1];
};

private _riverTris = [];
private _mainRoadsTris = [];
private _mainRoadsLines = [];
private _roadsTris = [];
private _roadsLines = [];
private _tracksTris = [];
private _tracksLines = [];
private _trailsTris = [];
private _trailsLines = [];

private _hideTerrainObjects = nearestTerrainObjects [[worldSize/2, worldSize/2], ["HIDE"], worldSize];
{
    private _obj = _x;
    (getModelInfo _obj) params ["_modelName"];
    if ((RIVER_OBJS find _modelName) > -1) then {
        private _points = (_obj call _calculateRiverTris);
        _riverTris append _points;
    };
} forEach _hideTerrainObjects;

private _roadTerrainObjects = nearestTerrainObjects [[worldSize/2, worldSize/2], ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"], worldSize];
{
    private _obj = _x;

    (getRoadInfo _obj) params ["_type", "_width", "_isPedestrian", "", "", "", "_begPos", "_endPos", "_isBridge"];

    if (_isBridge) then {
        if (count ([_begPos, _endPos] inAreaArray AREA) < 2) exitWith {};

        private _p1 = _obj modelToWorld (_obj selectionPosition "lb");
        private _p2 = _obj modelToWorld (_obj selectionPosition "le");
        private _p3 = _obj modelToWorld (_obj selectionPosition "pe");
        private _p4 = _obj modelToWorld (_obj selectionPosition "pb");

        switch _type do {
            case "ROAD": {
                _roadsTris append [_p1, _p2, _p3, _p3, _p4, _p1];
                _roadsLines append [[_p1, _p2], [_p3, _p4]];
            };
            case "MAIN ROAD": {
                _mainRoadsTris append [_p1, _p2, _p3, _p3, _p4, _p1];
                _mainRoadsLines append [[_p1, _p2], [_p3, _p4]];
            };
            case "TRACK": {
                _tracksTris append [_p1, _p2, _p3, _p3, _p4, _p1];
                _tracksLines append [[_p1, _p2], [_p3, _p4]];
            };
            case "TRAIL": {
                _trailsTris append [_p1, _p2, _p3, _p3, _p4, _p1];
                _trailsLines append [[_p1, _p2], [_p3, _p4]];
            };
        }
    };
} forEach _roadTerrainObjects;

private _colorSea =           getArray (configFile >> "RscMapControl" >> "colorSea");
private _colorMainRoadsFill = getArray (configFile >> "RscMapControl" >> "colorMainRoadsFill");
private _colorRoadsFill =     getArray (configFile >> "RscMapControl" >> "colorRoadsFill");
private _colorTracksFill =    getArray (configFile >> "RscMapControl" >> "colorTracksFill");
private _colorTrailsFill =    getArray (configFile >> "RscMapControl" >> "colorTrailsFill");
private _colorMainRoads =     getArray (configFile >> "RscMapControl" >> "colorMainRoads");
private _colorRoads =         getArray (configFile >> "RscMapControl" >> "colorRoads");
private _colorTracks =        getArray (configFile >> "RscMapControl" >> "colorTracks");
private _colorTrails =        getArray (configFile >> "RscMapControl" >> "colorTrails");

private _ctrlConfig = (configfile >> "RscDisplayMainMap" >> "controlsBackground" >> "CA_Map");
_colorSea =           [_ctrlConfig, "colorSea", _colorSea] call BIS_fnc_returnConfigEntry;
_colorMainRoadsFill = [_ctrlConfig, "colorMainRoadsFill", _colorMainRoadsFill] call BIS_fnc_returnConfigEntry;
_colorRoadsFill =     [_ctrlConfig, "colorRoadsFill", _colorRoadsFill] call BIS_fnc_returnConfigEntry;
_colorTracksFill =    [_ctrlConfig, "colorTracksFill", _colorTracksFill] call BIS_fnc_returnConfigEntry;
_colorTrailsFill =    [_ctrlConfig, "colorTrailsFill", _colorTrailsFill] call BIS_fnc_returnConfigEntry;
_colorMainRoads =     [_ctrlConfig, "colorMainRoads", _colorMainRoads] call BIS_fnc_returnConfigEntry;
_colorRoads =         [_ctrlConfig, "colorRoads", _colorRoads] call BIS_fnc_returnConfigEntry;
_colorTracks =        [_ctrlConfig, "colorTracks", _colorTracks] call BIS_fnc_returnConfigEntry;
_colorTrails =        [_ctrlConfig, "colorTrails", _colorTrails] call BIS_fnc_returnConfigEntry;

grad_markRivers_rivers = [
    _colorSea call BIS_fnc_colorRGBAtoTexture,
    _riverTris,
    [
        [ _mainRoadsTris, _mainRoadsLines, _colorMainRoadsFill call BIS_fnc_colorRGBAtoTexture, _colorMainRoads ],
        [ _roadsTris, _roadsLines, _colorRoadsFill call BIS_fnc_colorRGBAtoTexture, _colorRoads ],
        [ _tracksTris, _tracksLines, _colorTracksFill call BIS_fnc_colorRGBAtoTexture, _colorTracks ],
        [ _trailsTris, _trailsLines, _colorTrailsFill call BIS_fnc_colorRGBAtoTexture, _colorTrails ]
    ]
];

publicVariable "grad_markRivers_rivers";