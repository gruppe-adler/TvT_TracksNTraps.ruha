params ["_vehicle"];

private _repairAction = [
    "RepairCritical",
    "Repair Critical Damage",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        [_target] call gradSB_fnc_damageRepair;
    }, {
        ([_target] call gradSB_fnc_canBeRepaired) && (_player getVariable ["ACE_IsEngineer", false])
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _repairAction] call ace_interact_menu_fnc_addActionToObject;