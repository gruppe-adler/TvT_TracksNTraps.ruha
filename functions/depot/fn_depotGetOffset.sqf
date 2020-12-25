params ["_relPos"];

_relPos params ["_distance", "_heading"];

private _positionDummy = player getPos [_distance, _heading + getDir player];

_positionDummy
