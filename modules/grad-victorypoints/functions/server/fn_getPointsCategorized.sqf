#include "..\component.hpp"

params ["_side"];

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

_categories
