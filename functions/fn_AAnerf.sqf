/*

  not in use in current concept

*/

params ["_vehicle"];

SB_restrictGun = {
    params ["_vehicle"];

    _vehicle setVariable ["SB_aaRestricted", true];

    private _turret = currentWeapon gunner _vehicle;

    private _ammo = magazinesTurret _turret;
    _vehicle setVariable ["SB_aaAmmoCache", _ammo];

    removeMagazinesTurret _turret;
};

SB_unRestrictGun = {
    params ["_vehicle"];

    _vehicle setVariable ["SB_aaRestricted", false];

    private _turret = currentWeapon gunner _vehicle;

    private _ammo = _vehicle getVariable ["SB_aaAmmoCache", []];

    {
        vehicle addMagazineTurret [_x, _turret, 1];
    } forEach _ammo;

    _vehicle setVariable ["SB_aaAmmoCache", []];
};


[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    private _gunner = gunner _vehicle;

    if (isNull _gunner) exitWith {};

    private _aimAngle = acos ((weaponDirection currentWeapon _gunner) select 2);
    private _isRestricted = _vehicle getVariable ["SB_aaRestricted", false];

    if (_aimAngle < 20 && !_isRestricted) then {
        [_vehicle] call SB_restrictGun;
    };

    if (_aimAngle < 20) then {
        ["Turret Angle must be greater than 20!"] remoteExec ["hintSilent", gunner _vehicle];
    };

    if (_aimAngle >= 20 && _isRestricted) then {
        [_vehicle] call SB_unRestrictGun;
    };

}, 0.1, [_vehicle]] call CBA_fnc_addPerFrameHandler;
