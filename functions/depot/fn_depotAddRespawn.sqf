// run on server only

params ["_side", "_object", "_name", ["_add", false]];

if (_add) then {
    private _id = [_side, _object, "Depot"] call BIS_fnc_addRespawnPosition;    
    _object setVariable ["gradTnT_respawnID", _id, true];
} else {
    private _id = _object getVariable ["gradTnT_respawnID",[]];    
    if (count _id > 0) then {
        _id call BIS_fnc_removeRespawnPosition;
    };
};