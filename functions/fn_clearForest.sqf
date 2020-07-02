/*

    clears every other tree to make forests lighter but not totally delete them

*/

params ["_logic"];

if (!isServer) exitWith {};
if !(_logic isKindOf "LocationArea_F") exitWith {diag_log format ["error: %1 is not an area logic.",_logic]; };

    //--- get area dimensions
private _pos = position _logic;
private _areas = [];

{   
    _areas pushBackUnique _x;
} foreach (_logic call bis_fnc_moduleTriggers);

_areas params ["_area"];

// systemChat (str _area);

private _size = ((triggerArea _area) select 0) * 2;

private _found = nearestTerrainObjects [_logic, ["TREE","SMALL TREE"], _size, false, true];

{
    if (_x inArea _area) then {
        if (random 20 > 1) then {
            // diag_log format ["hiding %1", _forEachIndex];
            _x hideObjectGlobal true;
            _x allowDamage false;
        };
    };
} forEach _found;