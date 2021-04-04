params ["_helper"];


private _possibleBridges = nearestObjects [getPos _helper, [], 30];
private _indizes = [];

private _bridges = _helper getVariable ["gradTnT_connectedBridges", []];

{
    _x setDamage 0;
} forEach _possibleBridges;


_helper setVariable ["gradTnT_bridgeDestroyed", false, true];

[_helper, false] remoteExecCall ["hideObjectGlobal", 2];

[   20, 
    [], 
    {Hint "Repair Finished."}, 
    {hint "Repair aborted!"}, 
    "Repairing Bridge"
] call ace_common_fnc_progressBar