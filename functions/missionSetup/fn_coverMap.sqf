params ["_logic"];

if (!isServer) exitWith {};
if !(_logic isKindOf "LocationArea_F") exitWith {diag_log format ["%1 is not an area logic.",_logic]};

private _sizeOut = 50000;

//--- get area dimensions
private _pos = position _logic;
private _area = [0,0,0];

{
    _pos = position _x;
    _area = triggerarea _x;
} foreach (_logic call bis_fnc_moduleTriggers);

private _posX = _pos select 0;
private _posY = _pos select 1;
private _sizeX = _area select 0;
private _sizeY = _area select 1;
private _dir = _area select 2;

for "_i" from 0 to 270 step 90 do {
    _size1 = [_sizeX,_sizeY] select (abs cos _i);
    _size2 = [_sizeX,_sizeY] select (abs sin _i);
    _sizeMarker = [_size2,_sizeOut] select (abs sin _i);
    _dirTemp = _dir + _i;
    _markerPos = [
        _posX + (sin _dirTemp * _sizeOut),
        _posY + (cos _dirTemp * _sizeOut)
    ];

    _marker = format ["gradTnT_moduleCoverMap_%1",_i];
    createmarker [_marker,_markerPos];
    _marker setmarkerpos _markerPos;
    _marker setmarkersize [_sizeMarker,_sizeOut - _size1];
    _marker setmarkerdir _dirTemp;
    _marker setmarkershape "rectangle";
    _marker setmarkerbrush "solidFull";
    _marker setmarkercolor "colorBlack";
    _marker setMarkerAlpha 1;

    _markerPos = [
        _posX + (sin _dirTemp * _size1) + (sin (_dirTemp + 90) * _size2),
        _posY + (cos _dirTemp * _size1) + (cos (_dirTemp + 90) * _size2)
    ];
    _marker = format ["gradTnT_moduleCoverMap_dot_%1",_i];
    createmarker [_marker,_markerPos];
    _marker setmarkerpos _markerPos;
    _marker setmarkersize [0.75,0.75];
    _marker setmarkerdir _dir;
    _marker setmarkertype "mil_box_noShadow";
    _marker setmarkercolor "colorBlack";
};

private _marker = "gradTnT_moduleCoverMap_border";
createmarker [_marker,_pos];
_marker setmarkerpos _pos;
_marker setmarkersize [_sizeX,_sizeY];
_marker setmarkerdir _dir;
_marker setmarkershape "rectangle";
_marker setmarkerbrush "border";
_marker setmarkercolor "colorblack";

private _distanceBetweenPosts = 20;

private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_90");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_90");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") getPos [_i*(_distance/_amount) , _dir];
    private _pole = "land_gm_wall_gc_borderpost_01" createVehicle [0,0,0];
    _pole setPos _position;
    _pole setVectorUp [0,0,1];
};

private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_180");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_180");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") getPos [_i*(_distance/_amount) , _dir];
    private _pole = "land_gm_wall_gc_borderpost_01" createVehicle [0,0,0];
    _pole setPos _position;
    _pole setVectorUp [0,0,1];
};


private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_270");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_270");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") getPos [_i*(_distance/_amount) , _dir];
    private _pole = "land_gm_wall_gc_borderpost_01" createVehicle [0,0,0];
    _pole setPos _position;
    _pole setVectorUp [0,0,1];
};


private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_0");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_0");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") getPos [_i*(_distance/_amount) , _dir];
    private _pole = "land_gm_wall_gc_borderpost_01" createVehicle [0,0,0];
    _pole setPos _position;
    _pole setVectorUp [0,0,1];
};

