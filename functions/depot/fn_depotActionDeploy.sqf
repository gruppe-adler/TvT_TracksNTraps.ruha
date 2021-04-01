/*

  adds self interaction to build depots

*/

private _buildAction = [
    "BuildDepot",
    "Build Depot",
    "functions\bft\data\depot.paa",
    {
        if (player getVariable ["gradTnT_depotsBuilt", 0] >= gradTnT_MAX_DEPOTS) exitWith {
            private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", gradTnT_MAX_DEPOTS];
            hintSilent _string;
        };
        private _bridgeVehicle = [gradTnT_DEPOTS_VEHICLE_WEST, gradTnT_DEPOTS_VEHICLE_EAST] select ( side player == east );
        private _vehicleNear = false;
        private _canBuild = true;
        if (_bridgeVehicle != "") then {
            if (count (player nearObjects [_bridgeVehicle, gradTnT_DEPOTS_VEHICLE_DISTANCE]) == 0) exitWith {
              private _string = format ["No Engineer Vehicle near your position (needs to be closer than %1 m).", gradTnT_DEPOTS_VEHICLE_DISTANCE];
              hintSilent _string;
              _canBuild = false;
            };
        };
        if (_canBuild) then {
            call gradTnT_fnc_depotPlace;
        };
    }, {
          vehicle player == player
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions", "Engineer_Buildings"], _buildAction] call ace_interact_menu_fnc_addActionToObject;
