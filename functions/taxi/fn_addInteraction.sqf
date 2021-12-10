params ["_vehicle"];

if (isNull _vehicle) exitWith {}; // JIP handling

private _vehicleclass = typeOf _vehicle;
private _interactionID = format ["gradTnT_interactionID_%1", vehicleclass];

// prevent adding the same action twice and more
if (missionNamespace getVariable [_interactionID, false]) exitWith {};
missionNamespace setVariable [_interactionID, true];

private _openTaxiMenu = [ 
    "openTaxiMenu", 
    "Despawn Vehicle to regain points", 
    "", 
    { 
        params ["_target"];
        private _side = _target getVariable ["gradTnT_side", civilian];
        deleteVehicle _target;
        ["gradTnT_points", ["car_deposit", [_side] call gradTnT_fnc_getOpposingSide]] call CBA_fnc_serverEvent;
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
 
[_vehicle, 0, ["ACE_MainActions"], _openTaxiMenu] call ace_interact_menu_fnc_addActionToObject;