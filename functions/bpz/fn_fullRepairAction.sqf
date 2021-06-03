["LandVehicle", "init", {
    params ["_vehicle"];

    private _fullRepairAction = [
        "fullRepair",
        "Repair Action",
        "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
        {
            
            [15, [_target], {
                params ["_args"];
                _args params ["_vehicle"];

                _target setDamage 0;
                hint "Fully repaired vehicle";
            }, {
                params ["_args"];
                _args params ["_vehicle"];
                hint "Repair aborted!";
            }, "Fully repairing vehicle"] call ace_common_fnc_progressBar;
        }, {
            _player getVariable ["ACE_isEngineer", 0] == 2 &&
            [_player] call gradTnT_bridgeDestruction_fnc_isRepairVehicleNear
        },{},nil,"",3,[false,false,false,false,false]
    ] call ace_interact_menu_fnc_createAction;

    [_vehicle, 0, ["ACE_MainActions"], _fullRepairAction] call ace_interact_menu_fnc_addActionToObject;

}, true, [], true] call CBA_fnc_addClassEventHandler;