params ["_side"];

private _opposingSide = [west, east] select { _x != _side };

_opposingSide#0
