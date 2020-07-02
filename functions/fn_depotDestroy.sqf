params ["_depot"];

_depot setVariable ["gradSB_depotDestroyed", true, true];
_depot setDamage [1, false];

private _shelter = _depot getVariable ["gradSB_shelter", objNull];
private _camoNet = _depot getVariable ["gradSB_camoNet", objNull];

_shelter setDamage [1, false];
_camoNet setDamage [1, false];

[_depot, true] remoteExec ["gradSB_fnc_depotDestroy", 0, true];