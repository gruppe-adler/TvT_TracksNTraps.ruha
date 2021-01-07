// add draw eventhandler to map

(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", "_this call gradTnT_fnc_bftDrawIcons"];

// add existing vehicles to system
if (isServer) then {
    {
        [_x] call gradTnT_fnc_bftAdd;
    } forEach vehicles;
};