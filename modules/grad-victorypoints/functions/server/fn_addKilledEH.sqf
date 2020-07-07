#include "..\component.hpp"

private _handle = "grad_points_playerKilledEH";
private _code = {
    params ["_victim","_victimSide","_victimIsPlayer","_killer","_killerSide","_killerIsPlayer","_killTime"];
    private ["_points","_category"];

    if (_killerSide == CIVILIAN) exitWith {};
    if (_victim == _killer) exitWith {};

    switch (true) do {
        case (_victimSide == CIVILIAN): {
            _points = [_killerSide,"civKilled"] call grad_points_fnc_getPointsVar;
            _category = "Civilians killed";
        };
        case (_victimSide getFriend _killerSide > 0): {
            _points = 0;
            _category = "";
        };
        case (_victimIsPlayer): {
            _points = [_killerSide,"playerKilled"] call grad_points_fnc_getPointsVar;
            _category = "Players killed";
        };
        default {
            _points = [_killerSide,"aiKilled"] call grad_points_fnc_getPointsVar;
            _category = "AI killed";
        };
    };

    [_killerSide,_points,_category] call grad_points_fnc_addPoints;
};

[_handle,_code] call grad_common_fnc_addUnitKilledEH;
