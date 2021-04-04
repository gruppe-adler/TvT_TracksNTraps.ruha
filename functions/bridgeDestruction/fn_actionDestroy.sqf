params ["_helper"];

// _helper setObjectTexture [0, "#(argb,8,8,3)color(1,1,1,0,ca)"];

private _action = [
    "gradTnT_bridgeDestruction",
    "Destroy Bridge",
    "",
    {
        [_target, _player] call gradTnT_bridgeDestruction_fnc_destroy;
    },
    {
        !(_target getVariable ["gradTnT_bridgeDestroyed", false])
    },
    nil,
    nil,
    nil,
    3,
    [false, true, false, false, false]
] call ace_interact_menu_fnc_createAction;

[_helper, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;



private _repairHelpers = nearestObjects [_helper, ["land_gm_euro_misc_powerbox_01"], 50];

{
  [_x, _helper] call gradTnT_bridgeDestruction_fnc_actionRepair;
} forEach _repairHelpers;


if (isServer) then {
    private _possibleBridges = nearestObjects [getPos _helper, [], 30];
    private _bridges = [];

    private _bridgeSegments = [
        "gm_euro_bridge_02_20_mainroad_half.p3d",
        "gm_euro_bridge_01_25_badroad.p3d",
        "gm_euro_bridge_02_20_normalroad_half.p3d"
    ];

    {
        private _p3d = getModelInfo _x select 0;
        private _isBridge = _p3d in _bridgeSegments;
        if (_isBridge) then {
            _bridges pushBackUnique _x;
        };
    } forEach _possibleBridges;

    // systemChat str _indizes;

    _helper setVariable ["gradTnT_connectedBridges", _bridges, true];
};