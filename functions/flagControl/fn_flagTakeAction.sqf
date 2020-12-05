params ["_vehicle"];


private _flagTakeAction = [
    "flagTake",
    "Take Flag",
    "\A3\ui_f\data\igui\cfg\actions\takeflag_ca.paa",
    {
        [_player] call gradTnT_fnc_flagTake;
    }, {
        isNull (_player getVariable ["gradTnT_ownerOfFlag", objNull])
    },{},nil,[0,0,0],5,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _flagTakeAction] call ace_interact_menu_fnc_addActionToObject;