/*

  adds self interaction to build depots

*/

private _buildAction = [
    "BuildDepot",
    "Build Depot",
    "functions\bft\data\depot.paa",
    {
        private _side = side player;
        private _varKey = format ["gradTnT_depotsBuilt_%1", _side];
        if (missionNamespace getVariable [_varKey, 0] >= gradTnT_MAX_DEPOTS) exitWith {
            private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", gradTnT_MAX_DEPOTS];
            hintSilent _string;
        };
        if ([_player] call gradTnT_bridgeDestruction_fnc_isRepairVehicleNear) then {
            call gradTnT_fnc_depotPlace;
        };
    }, {
          vehicle player == player
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions", "Engineer_Buildings"], _buildAction] call ace_interact_menu_fnc_addActionToObject;
