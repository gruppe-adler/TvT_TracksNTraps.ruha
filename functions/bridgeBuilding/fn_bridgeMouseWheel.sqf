private _bridgeDummy = player getVariable ["gradTnT_carryBridgeDummy", objNull];
if (isNull _bridgeDummy) exitWith {};

private _offset = _bridgeDummy getVariable ["gradTnT_bridgeAttachPosition", [0, 16, 1.5]];

_offset params ["_carryAttachX", "_carryAttachY", "_carryAttachH"];

// min and max height player can carry bridge on
private _min = -3;
private _max = 3;

if ((_this select 1) > 1 && (_carryAttachH < _max)) then {
  _carryAttachH = _carryAttachH + 0.1;
  addCamShake [4, 1, 2];
};
if ((_this select 1) < -1 && (_carryAttachH > _min)) then {
  _carryAttachH = _carryAttachH - 0.1;
  addCamShake [4, 1, 2];
};

_bridgeDummy attachTo [player,[_carryAttachX, _carryAttachY, _carryAttachH]];
_bridgeDummy setVariable ["gradTnT_bridgeAttachPosition", [_carryAttachX, _carryAttachY, _carryAttachH]];