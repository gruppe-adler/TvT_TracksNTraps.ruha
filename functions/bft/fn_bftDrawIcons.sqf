params ["_control"];

private _side = [_vehicle, true] call BIS_fnc_objectSide;
private _keyAlive = format ["gradTnT_bftIconsAlive_%1", _side];

private _alive = missionNamespace getVariable [_keyAlive, []];

{   
    private _vehicle = _x;
    private _vehicleIcon = "";
    private _crewIcon = "";

    if (_vehicle isKindOf "gm_tracked_Tank_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_armor.paa";
    };

    if (_vehicle isKindOf "gm_wheeled_APC_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_recon.paa";
    };

    if (_vehicle isKindOf "gm_wheeled_truck_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_engineer.paa";
    };

    if (_vehicle isKindOf "gm_helicopter_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_air.paa";
    };

    if (_vehicle isKindOf "gm_wheeled_car_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_cmd.paa";
    };

    private _crewCount = count ((crew _vehicle) select { alive _x });
    private _turretCount = count (_vehicle call BIS_fnc_vehicleCrewTurrets);

    // if no turrets maybe its a car, then every seat is counted
    if (_turretCount == 0) then {
        _turretCount = count ( fullCrew [_vehicle, "", true]);
    };

    private _crewIcon = getMissionPath "functions\bft\gui\" + "bft_crew_" + str _crewCount + "_" + str _turretCount + ".paa";

    // vehicle icon
    _control drawIcon 
    [
        _vehicleIcon,
        [side player, false] call BIS_fnc_sideColor,
        getPos _vehicle,
        40,
        40,
        0,
        "",
        1,
        0.03,
        "TahomaB",
        "center"
    ];

    // crew icon
    _control drawIcon 
    [
        _crewIcon,
        [side player, false] call BIS_fnc_sideColor,
        getPos _vehicle,
        40,
        40,
        0,
        "",
        1,
        0.03,
        "TahomaB",
        "right"
    ];

    _control drawIcon 
    [
        "#(rgb,1,1,1)color(1,1,1,0)",
        [0.1,0.1,0.1,1],
        getPos _vehicle,
        50,
        50,
        0,
        _vehicle getVariable ["gradTnT_bftGroupID_prefix", "A"],
        0,
        0.05,
        "RobotoCondensedBold",
        "left"
    ];

    _control drawIcon 
    [
        "#(rgb,1,1,1)color(1,1,1,0)",
        [0.1,0.1,0.1,1],
        getPos _vehicle,
        50,
        50,
        0,
        _vehicle getVariable ["gradTnT_bftGroupID_suffix", "1"],
        0,
        0.05,
        "RobotoCondensedBold",
        "right"
    ];   

} forEach _alive;