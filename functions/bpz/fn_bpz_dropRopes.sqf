
private _vehicle = player getVariable ["gradTnT_ropesVehicle", objNull];
private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];
private _helper = player getVariable ["gradTnT_ropesHelper", objNull];
private _ropes = player getVariable ["gradTnT_ropes", []];


player setVariable ["gradTnT_ropesPickedUp", false, true];
_hook setVariable ["canHook", true, true];

{
    _x params ["_rope"];
    player ropeDetach _rope;
} forEach _ropes;

deleteVehicle _helper;