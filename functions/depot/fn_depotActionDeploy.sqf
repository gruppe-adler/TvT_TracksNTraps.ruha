/*

  adds self interaction to build depots

*/


private _buildAction = [
    "BuildDepot",
    "Build Depot",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        if (player getVariable ["SB_depotsBuilt", 0] >= SB_MAX_DEPOTS) exitWith {
            private _string = format ["Depot Limit of %1 reached. Destroy one of the placed depots via ACE Interact to be able to build new ones.", SB_MAX_DEPOTS];
            hintSilent _string;
        };
        private _bridgeVehicle = [SB_DEPOTS_VEHICLE_WEST, SB_DEPOTS_VEHICLE_EAST] select { side player == east };
        private _vehicleNear = false;
        if (_bridgeVehicle != "") then {
            if (count (player nearObjects [_bridgeVehicle, SB_DEPOTS_VEHICLE_DISTANCE]) == 0) exitWith {
              private _string = format ["No Engineer Vehicle near your position (needs to be closer than %1 m).", SB_DEPOTS_VEHICLE_DISTANCE];
              hintSilent _string;
            };
        };
        call gradTnT_fnc_depotDrop;
    }, {
          true
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions"], _buildAction] call ace_interact_menu_fnc_addActionToObject;
