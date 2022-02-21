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
    createmarkerlocal [_marker,_markerPos];
    _marker setmarkerposlocal _markerPos;
    _marker setmarkersizelocal [_sizeMarker,_sizeOut - _size1];
    _marker setmarkerdirlocal _dirTemp;
    _marker setmarkershapelocal "rectangle";
    _marker setmarkerbrushlocal "solidFull";
    _marker setmarkercolorlocal "colorBlack";
    _marker setMarkerAlphalocal 1;

    _markerPos = [
        _posX + (sin _dirTemp * _size1) + (sin (_dirTemp + 90) * _size2),
        _posY + (cos _dirTemp * _size1) + (cos (_dirTemp + 90) * _size2)
    ];
    _marker = format ["gradTnT_moduleCoverMap_dot_%1",_i];
    createmarkerlocal [_marker,_markerPos];
    _marker setmarkerposlocal _markerPos;
    _marker setmarkersizelocal [0.75,0.75];
    _marker setmarkerdirlocal _dir;
    _marker setmarkertypelocal "mil_box_noShadow";
    _marker setmarkercolorlocal "colorBlack";
};

private _marker = "gradTnT_moduleCoverMap_border";
createmarkerlocal [_marker,_pos];
_marker setmarkerposlocal _pos;
_marker setmarkersizelocal [_sizeX,_sizeY];
_marker setmarkerdirlocal _dir;
_marker setmarkershapelocal "rectangle";
_marker setmarkerbrushlocal "border";
_marker setmarkercolorlocal "colorblack";

private _distanceBetweenPosts = 20;

private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_90");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_90");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_0") getPos [_i*(_distance/_amount) , _dir];
    private _pole = createSimpleObject ["land_gm_wall_gc_borderpost_01", AGLtoASL _position, true];
    _pole setVectorUp [0,0,1];
};

private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_180");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_180");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_90") getPos [_i*(_distance/_amount) , _dir];
    private _pole = createSimpleObject ["land_gm_wall_gc_borderpost_01", AGLtoASL _position, true];
    _pole setVectorUp [0,0,1];
};


private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_270");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_270");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_180") getPos [_i*(_distance/_amount) , _dir];
    private _pole = createSimpleObject ["land_gm_wall_gc_borderpost_01", AGLtoASL _position, true];
    _pole setVectorUp [0,0,1];
};


private _dir = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") getDir (getMarkerPos "gradTnT_moduleCoverMap_dot_0");
private _distance = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") distance2d (getMarkerPos "gradTnT_moduleCoverMap_dot_0");
private _amount = floor (_distance/_distanceBetweenPosts);

for "_i" from 1 to _amount do {
    private _position = (getMarkerPos "gradTnT_moduleCoverMap_dot_270") getPos [_i*(_distance/_amount) , _dir];
    private _pole = createSimpleObject ["land_gm_wall_gc_borderpost_01", AGLtoASL _position, true];
    _pole setVectorUp [0,0,1];
};

