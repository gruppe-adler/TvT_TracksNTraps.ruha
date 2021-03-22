params ["_vehicle"];

private _ropesCrane = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];
private _ropesHook = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];
private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];

{
    params ["_rope"];

    ropeDestroy _rope;

} forEach _ropesCrane;

{
    params ["_rope"];

    ropeDestroy _rope;

} forEach _ropesHook;

deleteVehicle _hook;