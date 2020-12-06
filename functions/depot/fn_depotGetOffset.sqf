params ["_object", "_relPos"];

private _positionDummy = (getPosVisual player) getPos _relPos;
_positionDummy params ["_positionDummyX", "_positionDummyY", "_positionDummyH"];

private _positionGroundOffset = _object worldToModelVisual [_positionDummyX, _positionDummyY, 0];
_positionGroundOffset