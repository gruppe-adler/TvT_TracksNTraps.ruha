params ["_vehicle"];

if (!alive _vehicle) exitWith {};

private _side = [_vehicle, true] call BIS_fnc_objectSide;
private _keyAlive = format ["gradTnT_bftIconsAlive_%1", _side];

private _vehiclesAlive = missionNamespace getVariable [_keyAlive, []];
_vehiclesAlive pushBackUnique _vehicle;
missionNamespace setVariable [_keyAlive, _vehiclesAlive, true];


_vehicle addMPEventHandler ["MPKilled", {
    params ["_vehicle", "_killer", "_instigator", "_useEffects"];

    private _side = [_vehicle, true] call BIS_fnc_objectSide;
    private _keyAlive = format ["gradTnT_bftIconsAlive_%1", _side];
    private _keyDead = format ["gradTnT_bftIconsDead_%1", _side];

    private _vehiclesAlive = missionNamespace getVariable [_keyAlive, []];
    _vehiclesAlive deleteAt (_vehiclesAlive find _vehicle);
    missionNamespace setVariable [_keyAlive, _vehiclesAlive, true];

    [_vehicle] call gradTnT_fnc_bftMarkerDead;
}];