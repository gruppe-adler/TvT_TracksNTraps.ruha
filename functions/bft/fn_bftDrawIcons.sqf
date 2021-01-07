params ["_control"];

private _alive = missionNamespace getVariable ["gradTnT_bftIconsAlive", []];
private _dead = missionNamespace getVariable ["gradTnT_bftIconsDead", []];

{   
    private _vehicle = _x;
    private _vehicleIcon = "";
    private _crewIcon = "";

    if (_vehicle isKindOf "gm_tracked_Tank_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_armor2.paa";
    };

    if (_vehicle isKindOf "gm_wheeled_APC_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_recon2.paa";
    };

    if (_vehicle isKindOf "gm_wheeled_truck_base") then {
        _vehicleIcon = getMissionPath "functions\bft\gui\bft_engineer2.paa";
    };

    private _crewCount = count ((crew _vehicle) select { alive _x });
    private _turretCount = count (_vehicle call BIS_fnc_vehicleCrewTurrets);

    // if no turrets maybe its a car, then every seat is counted
    if (_turretCount == 0) then {
        _turretCount = count ( fullCrew [_vehicle, "", true]);
    };

    private _crewIcon = getMissionPath "functions\bft\gui\" + "bft_crew_" + str _crewCount + "_" + str _turretCount + "2.paa";

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
        40,
        40,
        0,
        _vehicle getVariable ["gradTnT_bftGroupID", "Alpha"],
        1,
        0.04,
        "TahomaB",
        "center"
    ];

} forEach _alive;

{
  
} forEach _dead;