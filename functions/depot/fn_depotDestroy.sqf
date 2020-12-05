params ["_depot"];

_depot setVariable ["gradTnT_depotDestroyed", true, true];
_depot setDamage [1, false];

private _shelter = _depot getVariable ["gradTnT_shelter", objNull];
private _camoNet = _depot getVariable ["gradTnT_camoNet", objNull];

_shelter setDamage [1, false];
_camoNet setDamage [1, false];

[_depot, true] remoteExec ["gradTnT_fnc_depotDestroy", 0, true];