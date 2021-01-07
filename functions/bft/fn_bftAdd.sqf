params ["_vehicle"];

if (!alive _vehicle) exitWith {};

private _vehiclesAlive = missionNamespace getVariable ["gradTnT_bftIconsAlive", []];
_vehiclesAlive pushBackUnique _vehicle;
missionNamespace setVariable ["gradTnT_bftIconsAlive", _vehiclesAlive, true];


_vehicle addMPEventHandler ["MPKilled", {
    params ["_vehicle", "_killer", "_instigator", "_useEffects"];

    private _vehiclesAlive = missionNamespace getVariable ["gradTnT_bftIconsAlive", []];
    _vehiclesAlive deleteAt (_vehiclesAlive find _vehicle);
    missionNamespace setVariable ["gradTnT_bftIconsAlive", _vehiclesAlive, true];

    private _vehiclesDead = missionNamespace getVariable ["gradTnT_bftIconsDead", []];
    _vehiclesDead pushBackUnique _vehicle;
    missionNamespace setVariable ["gradTnT_bftIconsDead", _vehiclesDead, true];
}];