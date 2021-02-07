params ["_player", "_depotHelper"];

private _depotObjects = _depotHelper getVariable ["gradTnt_depotObjects", []];
private _depot = _depotObjects select 0;

{
  _x setDamage [1, false];

  // make depot dark bc no destr model
  if (_forEachIndex == 0) then {
    _x setObjectTextureGlobal [0,"#(rgb,8,8,3)color(0.025,0.05,0.025,1)"];
  };
} forEach _depotObjects;

deleteVehicle _depotHelper;

_depot setVariable ["gradTnT_depotDestroyed", true, true];

// down counter
private _side = side _player;
private _depotsBuiltID = format ["gradTnT_depotsBuilt_%1", _side];
private _depotsBuilt = missionNameSpace getVariable [_depotsBuiltID, 0];
_depotsBuilt = _depotsBuilt -1;
missionNameSpace setVariable [_depotsBuiltID, _depotsBuilt, true];

// if destroying enemy depot, give points
private _depotSide = _depot getVariable ["gradTnT_depotSide", sideUnknown];
if (_side != _depotSide) then {
    ["gradTnT_points", ["depot", _side]] call CBA_fnc_serverEvent;
};