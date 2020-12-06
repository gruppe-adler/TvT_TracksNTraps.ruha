params ["_depot"];

private _depotObjects = _depot getVariable ["gradTnt_depotObjects", []];

{
  _x setDamage [1, false];
} forEach _depotObjects;

_depot setVariable ["gradTnT_depotDestroyed", true, true];
[_depot, true] remoteExec ["gradTnT_fnc_depotDestroy", 0, true];