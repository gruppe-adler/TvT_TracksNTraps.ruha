["ace_explosives_place", 
{
    params ["_explosive", "_dir", "_pitch", "_unit"];

    if (local _unit) then {
        if (getPos _unit inArea "mrk_objective_area") then {

            private _itemClass = getText(ConfigFile >> "cfgAmmo" >> typeOf _explosive >> "ace_explosives_magazine");
            deleteVehicle _explosive;
            hint "You cant place explosives inside objective circle!";
        };
    };
}] call CBA_fnc_addEventhandler;


[{
    params ["_args", "_handle"];
   
    if (getPos ACE_player inArea "mrk_objective_area") then {
        grad_trenches_functions_allowDigging = false;
    } else {
        grad_trenches_functions_allowDigging = true;
    };

}, 1, []] call CBA_fnc_addPerFrameHandler;