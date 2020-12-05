/*
 * Name: gradTnT_fnc_clearForest
 * Author: nomisum, DerZade
 * Clears every other tree within all synchronized triggers to make forests lighter but not totally delete them.
 *
 * Arguments:
 * 0: Area logic <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this] call gradTnT_fnc_clearForest
 *
 */

#define FACTOR 10

params ["_logic"];

if (!isServer) exitWith {};
if !(_logic isKindOf "LocationArea_F") exitWith {diag_log format ["error: %1 is not an area logic.",_logic]; };

//--- get area dimensions
private _triggers = [];
{   
    _triggers pushBackUnique _x;
} foreach (_logic call bis_fnc_moduleTriggers);

private _allTrees = [];
{
    private _pos = getPos _x;
    (triggerArea _x) params ["_sizeX", "_sizeY", "_angle", "_isRectangle"];

    private _radius = (_sizeX max _sizeY);
    if (_isRectangle) then {
        _radius = sqrt (_sizeX ^ 2 + _sizeY ^ 2)
    };

    private _foundTrees = nearestTerrainObjects [_pos, ["TREE","SMALL TREE"], _radius, false, true];

    {
        _allTrees pushBackUnique _x;
    } forEach (_foundTrees inAreaArray _x);
} foreach _triggers;

{
    if (random FACTOR > 1) then {
        _x hideObjectGlobal true;

        if !(local _x) then {
            [_x, false] remoteExec ["allowDamage", _x];
        } else {
            _x allowDamage false;
        };
    };
} forEach _allTrees;