params ["_vehicle"];

gradTnT_camoNetSelections = [
    "camonet_hull_unhide",
    "camonet_mainturret_trav_unhide",
    "camonet_mainturret_elev_unhide",
    "camonet_01_unhide",
    "camonet_02_unhide"
];

gradTnT_FoilageSelections = [
    "camofoilage_hull_unhide",
    "camofoilage_mainturret_trav_unhide"
];

gradTnT_fnc_canAttachCamoNet = {
    params ["_vehicle"];

    private _canAttach = false;
    private _animationNames = animationNames _vehicle;
    
    {
        if (_x in _animationNames && !([_vehicle] call gradTnT_fnc_camoNetAttached)) then {
            _canAttach = true;
        };
    } forEach gradTnT_camoNetSelections;

    if (!alive _vehicle) then {
        _canAttach = false;
    };

    _canAttach
};

gradTnT_fnc_canAttachFoilage = {
    params ["_vehicle"];

    private _canAttach = false;
    private _animationNames = animationNames _vehicle;
    
    {
        if (_x in _animationNames && !([_vehicle] call gradTnT_fnc_foilageAttached)) exitWith {
            _canAttach = true;
        };
    } forEach gradTnT_FoilageSelections;

    if (!alive _vehicle) then {
        _canAttach = false;
    };

    _canAttach
};

gradTnT_fnc_camoNetAttached = {
    params ["_vehicle"];

    private _isAttached = false;
    private _animationNames = animationNames _vehicle;
    
    {
        if (_x in _animationNames) then {
            if (_vehicle animationSourcePhase _x == 1) then {
                _isAttached = true;
            };
        };
    } forEach gradTnT_camoNetSelections;

    _isAttached
};

gradTnT_fnc_foilageAttached = {
    params ["_vehicle"];

    private _isAttached = false;
    private _animationNames = animationNames _vehicle;
    
    {
        if (_vehicle animationSourcePhase _x == 1) then {
            _isAttached = true;
        };        
    } forEach gradTnT_foilageSelections;

    _isAttached
};


gradTnT_fnc_attachCamoNet = {
    params ["_vehicle", "_attachBool"];

    private _animationTo = if (_attachBool) then { 1 } else { 0 };
    private _animationNames = animationNames _vehicle;

    {
        if (_x in _animationNames) then {
            _vehicle animateSource [_x, _animationTo];
        };
    } forEach gradTnT_camoNetSelections;
};


gradTnT_fnc_attachFoilage = {
    params ["_vehicle", "_attachBool"];

    private _animationTo = if (_attachBool) then { 1 } else { 0 };
    private _animationNames = animationNames _vehicle;

    {
        if (_x in _animationNames) then {
            _vehicle animateSource [_x, _animationTo];
        };
    } forEach gradTnT_foilageSelections;
};


private _camoNetAttach = [
    "camoNetAttach",
    "Attach Camo Net",
    "functions\misc\data\attachCamoNet.paa",
    {
        [_target, true] call gradTnT_fnc_attachCamoNet;
    }, {
        [_target] call gradTnT_fnc_canAttachCamoNet
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _camoNetAttach] call ace_interact_menu_fnc_addActionToObject;

private _camoNetDetach = [
    "camoNetDetach",
    "Detach Camo Net",
    "functions\misc\data\detachCamoNet.paa",
    {
        [_target, false] call gradTnT_fnc_attachCamoNet;
    }, {
        [_target] call gradTnT_fnc_camoNetAttached
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _camoNetDetach] call ace_interact_menu_fnc_addActionToObject;

private _foilageAttach = [
    "foilageAttach",
    "Attach Foilage",
    "functions\misc\data\attachFoilage.paa",
    {
        [_target, true] call gradTnT_fnc_attachfoilage;
    }, {
        [_target] call gradTnT_fnc_canAttachfoilage
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _foilageAttach] call ace_interact_menu_fnc_addActionToObject;

private _foilageDetach = [
    "foilageDetach",
    "Detach Foilage",
    "functions\misc\data\detachFoilage.paa",
    {
        [_target, false] call gradTnT_fnc_attachfoilage;
    }, {
        [_target] call gradTnT_fnc_foilageAttached
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[_vehicle, 0, ["ACE_MainActions"], _foilageDetach] call ace_interact_menu_fnc_addActionToObject;