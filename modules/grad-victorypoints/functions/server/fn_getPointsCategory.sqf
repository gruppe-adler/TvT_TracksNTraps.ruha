#include "..\component.hpp"

params ["_side","_category"];

private _categories = switch (_side) do {
    case (WEST): {
        missionNamespace getVariable ["grad_common_points_west_categories",[]];
    };
    case (EAST): {
        missionNamespace getVariable ["grad_common_points_east_categories",[]];
    };
    case (INDEPENDENT): {
        missionNamespace getVariable ["grad_common_points_independent_categories",[]];
    };
    case (CIVILIAN): {
        missionNamespace getVariable ["grad_common_points_civilian_categories",[]];
    };
    default {
        []
    };
};

private _resultID = [_categories,_category] call BIS_fnc_findInPairs;
private _pointsCategory = if (_resultID < 0) then {
    0
} else {
    (_categories select _resultID) select 1
};

_pointsCategory
