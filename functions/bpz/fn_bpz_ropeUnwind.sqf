// [cursorObject, true] call gradTnT_fnc_bpz_ropeUnwind;

params ["_vehicle", ["_unwind", false], ["_instant", false], ["_length", 0]];


private _ropes = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];
private _speed = if (_instant) then { 20 } else { 1 };


if (_unwind && !_instant) then {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, _speed, -0.25, true]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
} else {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, _speed, 0.25, true]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
};

if (_instant && _unwind) then {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, _speed, _length, false]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
} else {
    {
      _x params ["_rope"];
      ropeUnwind [_rope, _speed, _length, false]; // reduce 1m in 1s as 1s is our PFH
    } forEach _ropes;
};

systemChat (str (ropeLength (_ropes select 0 select 0)) + " m");
