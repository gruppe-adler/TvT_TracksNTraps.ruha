#include "..\component.hpp"

private _cfg = missionConfigFile >> "CfgVictoryPoints";

_playerKilled_default = [_cfg,"playerKilled",0] call BIS_fnc_returnConfigEntry;
_aiKilled_default = [_cfg,"aiKilled",0] call BIS_fnc_returnConfigEntry;
_civKilled_default = [_cfg,"civKilled",0] call BIS_fnc_returnConfigEntry;

grad_points_playerKilled_west = [_cfg >> "BLUFOR","playerKilled",_playerKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_playerKilled_east = [_cfg >> "OPFOR","playerKilled",_playerKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_playerKilled_independent = [_cfg >> "INDEPENDENT","playerKilled",_playerKilled_default] call BIS_fnc_returnConfigEntry;

grad_points_aiKilled_west = [_cfg >> "BLUFOR","aiKilled",_aiKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_aiKilled_east = [_cfg >> "OPFOR","aiKilled",_aiKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_aiKilled_independent = [_cfg >> "INDEPENDENT","aiKilled",_aiKilled_default] call BIS_fnc_returnConfigEntry;

grad_points_civKilled_west = [_cfg >> "BLUFOR","civKilled",_civKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_civKilled_east = [_cfg >> "OPFOR","civKilled",_civKilled_default] call BIS_fnc_returnConfigEntry;
grad_points_civKilled_independent = [_cfg >> "INDEPENDENT","civKilled",_civKilled_default] call BIS_fnc_returnConfigEntry;

[] call grad_points_fnc_addKilledEH;
