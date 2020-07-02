params ["_depot"];

_depot setVariable ["SB_depotDestroyed", true, true];

_depot setDamage [1, false];


private _shelter = _depot getVariable ["SB_shelter", objNull];
private _camoNet = _depot getVariable ["SB_camoNet", objNull];

_shelter setDamage [1, false];
_camoNet setDamage [1, false]; 