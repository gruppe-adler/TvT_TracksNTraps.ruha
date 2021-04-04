/*

    adds self interaction to build bridges
    test: call gradTnT_fnc_bridgeActionBuild;

*/


private _buildAction = [
    "BuildBridge",
    "Build Bridge",
    "functions\bft\data\bridge.paa",
    {
        private _side = side player;
        private _varKey = format ["gradTnT_bridgesBuilt_%1", _side];
        if (missionNamespace getVariable [_varKey, 0] >= gradTnT_MAX_BRIDGES) exitWith {
            private _string = format ["Bridge Limit of %1 reached. Destroy one of the placed bridges via ACE Interact to be able to build new ones.", gradTnT_MAX_BRIDGES];
            hintSilent _string;
        };
        if ([_player] call gradTnT_bridgeDestruction_fnc_isRepairVehicleNear) then {
            call gradTnT_fnc_bridgePlace;
        };
    }, {
          vehicle player == player
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions", "Engineer_Buildings"], _buildAction] call ace_interact_menu_fnc_addActionToObject;
