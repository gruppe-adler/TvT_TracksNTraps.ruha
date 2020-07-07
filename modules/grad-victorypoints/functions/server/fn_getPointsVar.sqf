#include "..\component.hpp"

params ["_side","_event"];

_event = toUpper _event;

private _points = switch (_event) do {
    case ("PLAYERKILLED"): {
        switch (_side) do {
            case (WEST): {grad_points_playerKilled_west};
            case (EAST): {grad_points_playerKilled_east};
            case (INDEPENDENT): {grad_points_playerKilled_independent};
            default {0};
        }
    };
    case ("AIKILLED"): {
        switch (_side) do {
            case (WEST): {grad_points_aiKilled_west};
            case (EAST): {grad_points_aiKilled_east};
            case (INDEPENDENT): {grad_points_aiKilled_independent};
            default {0};
        }
    };
    case ("CIVKILLED"): {
        switch (_side) do {
            case (WEST): {grad_points_civKilled_west};
            case (EAST): {grad_points_civKilled_east};
            case (INDEPENDENT): {grad_points_civKilled_independent};
            default {0};
        }
    };
    default {0};
};

_points
