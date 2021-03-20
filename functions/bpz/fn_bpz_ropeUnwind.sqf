// [cursorObject, true] call gradTnT_fnc_bpz_ropeUnwind;

params ["_vehicle", "_unwind"];


private _ropes = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];

if (_unwind) then {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, .5, -0.5, true]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
} else {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, .5, 0.5, true]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
};

systemChat (str (ropeLength (_ropes select 0 select 0)) + " m");
