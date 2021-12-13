params ["_helper", "_parentHelper"];

if (isNull _helper) exitWith { diag_log "bridge for action not found"; };
if (isNull _parentHelper) exitWith { diag_log "bridge for action not found"; };

// _helper setObjectTexture [0, "#(argb,8,8,3)color(1,1,1,0,ca)"];

private _action = [
    "gradTnT_bridgeRepair",
    "Repair Bridge",
    "",
    {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_parentHelper"];
       [_parentHelper] call gradTnT_bridgeDestruction_fnc_repair;
    },
    {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_parentHelper"];
        (_parentHelper getVariable ["gradTnT_bridgeDestroyed", false]) && [_player] call gradTnT_bridgeDestruction_fnc_isRepairVehicleNear
    },
    nil,
    [_parentHelper],
    nil,
    3,
    [false, true, false, false, false]
] call ace_interact_menu_fnc_createAction;

[_helper, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;