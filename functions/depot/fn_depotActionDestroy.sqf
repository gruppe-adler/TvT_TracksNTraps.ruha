params ["_depot"];

private _helperObject = _depot getVariable ["gradTnT_depotHelper", objNull];

private _destroyAction = [
    "RepairHole",
    "Destroy Depot",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        private _depot = _target getVariable ["gradTnT_depotHelperDepot", objNull];
        [player, _depot] remoteExec ["gradTnT_fnc_depotDestroy", 2];
    }, {
        private _depot = _target getVariable ["gradTnT_depotHelperDepot", objNull];
        !(_depot getVariable ["gradTnT_depotDestroyed", false])
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_helperObject, 0, [], _destroyAction] call ace_interact_menu_fnc_addActionToObject;
// [_depot, 0, ["ACE_MainActions"], _destroyAction] call ace_interact_menu_fnc_addActionToObject;