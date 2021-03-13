params ["_vehicle"];

private _vehicleclass = typeOf _vehicle;
private _interactionID = format ["gradTnT_interactionID_%1", vehicleclass];

// prevent adding the same action twice and more
if (missionNamespace getVariable [_interactionID, false]) exitWith {};
missionNamespace setVariable [_interactionID, true];

private _openTaxiMenu = [ 
    "openTaxiMenu", 
    "Taxi Menü öffnen", 
    "", 
    { 
        call gradTnT_fnc_taxiDialogOpen; 
    }, 
    { 
        true
    }, 
    {}, 
    [], 
    [], 
    -1, 
    [true,true,false,false,true] 
] call ace_interact_menu_fnc_createAction; 
 
[_vehicle, 1, ["ACE_SelfActions"], _openTaxiMenu] call ace_interact_menu_fnc_addActionToObject;