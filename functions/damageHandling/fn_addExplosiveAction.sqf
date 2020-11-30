params ["_vehicle"];

private _explosiveAction = [
    "ExplosiveAction",
    "Attach Explosive (destroy and respawn) - 30s timer",
    "\A3\ui_f\data\map\respawn\icon_dead_ca.paa",
    {
        [_target] call gradSB_fnc_triggerExplosive;
    }, {
        true
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _explosiveAction] call ace_interact_menu_fnc_addActionToObject;




private _defuseAction = [
    "DefuseAction",
    "Remove Explosive (prevent respawn)",
    "\A3\ui_f\data\igui\cfg\actions\take_ca.paa",
    {
        [_target] call gradSB_fnc_removeExplosive;
    }, {
        _target getVariable ["gradSB_explosiveAttached", false]
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _defuseAction] call ace_interact_menu_fnc_addActionToObject;