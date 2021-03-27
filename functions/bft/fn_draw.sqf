/*
 * Name: gradTnT_bft_fnc_draw
 * Author: DerZade
 * Event handler for draw event on map controls.
 *
 * Arguments:
 * 1: Map control <CONTROL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */
params ["_control"];

if (isNil "gradTnT_bft_vehicles") exitWith {
	["Vehicles not found."] call BIS_fnc_error;
};

if (isNil "gradTnT_bft_turretsCache") then {
    gradTnT_bft_turretsCache = createHashMap;
};

private _getTurrets = {
    params ["_veh"];
    
    private _type = typeof _veh;

    if !(_type in gradTnT_bft_turretsCache) then {
        gradTnT_bft_turretsCache set [_type, [_type] call BIS_fnc_vehicleCrewTurrets];
    };

    gradTnT_bft_turretsCache get _type;
};

private _side = side player;
private _sideColor = [_side, false] call BIS_fnc_sideColor;

private _vehicles = gradTnT_bft_vehicles getOrDefault [_side, []];

// private _scale = 1 - (ctrlMapScale _control);
// private _iconSize = _scale * 40;
// private _iconSize2 = _scale * 50;
private _iconSize = 40;
private _iconSize2 = 50;

{   
    private _veh = _x;
    private _type = _veh getVariable ["gradTnT_bft_type", "unknown"];
    private _pos = getPos _veh;

    private _opacity = 1;
    if !(alive _veh) then {
        private _destroyedTime = _veh getVariable ["gradTnT_bft_destroyedTime", time];
        private _elapsed = (serverTime - _destroyedTime) min 300;
        _opacity = (1 - (_elapsed / 300)) * 0.75;
    };

    if (_opacity isEqualTo 0) then {continue};

    // vehicle icon
    private _vehicleIcon = getMissionPath format ["functions\bft\gui\bft\%1.paa", _type];
    _control drawIcon 
    [
        _vehicleIcon,
        [_sideColor#0, _sideColor#1, _sideColor#2, _opacity],
        _pos,
        _iconSize,
        _iconSize,
        0,
        "",
        0,
        0,
        "TahomaB",
        "center"
    ];

    if (alive _veh) then {
        private _turrets = _veh call _getTurrets;
        private _turretCount = (count _turrets) min 3;

        if (_turretCount isEqualTo 0) exitWith {};

        private _crewCount = ({ !(isNull (_veh turretUnit _x)) } count _turrets) min 3;
        private _crewIcon = getMissionPath format ["functions\bft\gui\bft\crew_%1_%2.paa", _crewCount, _turretCount];

        // crew icon
        _control drawIcon 
        [
            _crewIcon,
            [1, 1, 1, _opacity],
            _pos,
            _iconSize,
            _iconSize,
            0,
            "",
            0,
            0,
            "TahomaB",
            "center"
        ];
    } else {
        // destroyed icon
        _control drawIcon 
        [
            getMissionPath "functions\bft\gui\bft\destroyed.paa",
            [1, 1, 1, _opacity],
            _pos,
            _iconSize,
            _iconSize,
            0,
            "",
            0,
            0,
            "TahomaB",
            "center"
        ];
    };

    // callsign
    (_veh getVariable ["gradTnT_callsign", ["", ""]]) params ["_prefix", "_suffix"];

    if (_prefix isNotEqualTo "")  then {
        _control drawIcon 
        [
            "#(rgb,1,1,1)color(1,1,1,0)",
            [0.1,0.1,0.1, _opacity],
            _pos,
            _iconSize2,
            _iconSize2,
            0,
            _prefix,
            0,
            0.05,
            "RobotoCondensedBold",
            "left"
        ];
    };

    if (_suffix isNotEqualTo "")  then {
        _control drawIcon 
        [
            "#(rgb,1,1,1)color(1,1,1,0)",
            [0.1,0.1,0.1, _opacity],
            _pos,
            _iconSize2,
            _iconSize2,
            0,
            _suffix,
            0,
            0.05,
            "RobotoCondensedBold",
            "right"
        ];
    }; 
} forEach _vehicles;
