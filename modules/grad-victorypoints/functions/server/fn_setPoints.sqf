#include "..\component.hpp"

params ["_side","_points"];

_points = _points max 0;

private _successful = switch (_side) do {
    case (WEST): {missionNamespace setVariable ["grad_common_points_west",_points,true]; true};
    case (EAST): {missionNamespace setVariable ["grad_common_points_east",_points,true]; true};
    case (INDEPENDENT): {missionNamespace setVariable ["grad_common_points_independent",_points,true]; true};
    case (CIVILIAN): {missionNamespace setVariable ["grad_common_points_civilian",_points,true]; true};
    default {false};
};

_successful
