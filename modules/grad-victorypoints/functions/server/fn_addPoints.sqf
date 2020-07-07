#include "..\component.hpp"

if (!isServer) exitWith {_this remoteExec ["grad_points_fnc_addPoints",2,false]};

params ["_side","_points",["_category","Other"]];
private ["_newPoints","_categoriesVarName"];

if (_side == sideUnknown) exitWith {};

switch (_side) do {
    case (WEST): {
        _newPoints = (missionNamespace getVariable ["grad_common_points_west",0]) + _points;
        _categoriesVarName = "grad_common_points_west_categories";
        if (isNil _categoriesVarName) then {missionNamespace setVariable [_categoriesVarName,[]]};
        missionNamespace setVariable ["grad_common_points_west",_newPoints,true];
    };
    case (EAST): {
        _newPoints = (missionNamespace getVariable ["grad_common_points_east",0]) + _points;
        _categoriesVarName = "grad_common_points_east_categories";
        if (isNil _categoriesVarName) then {missionNamespace setVariable [_categoriesVarName,[]]};
        missionNamespace setVariable ["grad_common_points_east",_newPoints,true];
    };
    case (INDEPENDENT): {
        _newPoints = (missionNamespace getVariable ["grad_common_points_independent",0]) + _points;
        _categoriesVarName = "grad_common_points_independent_categories";
        if (isNil _categoriesVarName) then {missionNamespace setVariable [_categoriesVarName,[]]};
        missionNamespace setVariable ["grad_common_points_independent",_newPoints,true];
    };
    case (CIVILIAN): {
        _newPoints = (missionNamespace getVariable ["grad_common_points_civilian",0]) + _points;
        _categoriesVarName = "grad_common_points_civilian_categories";
        if (isNil _categoriesVarName) then {missionNamespace setVariable [_categoriesVarName,[]]};
        missionNamespace setVariable ["grad_common_points_civilian",_newPoints,true];
    };
    default {
        _newPoints = 0;
    };
};

private _categories = missionNamespace getVariable _categoriesVarName;

private _resultID = [_categories,_category] call BIS_fnc_findInPairs;
if (_resultID < 0) then {
    if (_points != 0) then {
        _categories pushBack [_category,_points]
    };
} else {
    _categoryPoints = ((_categories select _resultID) select 1) + _points;
    if (_categoryPoints != 0) then {
        _categories set [_resultID,[_category,((_categories select _resultID) select 1) + _points]];
    } else {
        _categories deleteAt _resultID;
    };
};

publicVariable _categoriesVarName;

_newPoints
