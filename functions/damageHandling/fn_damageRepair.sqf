params ["_vehicle"];

[5, [_vehicle], {
    params ["_args"];
    _args params ["_vehicle"];

    _vehicle setVariable ["gradTnT_criticalHit", false, true];

    private _smoke = _vehicle getVariable ["gradTnT_criticalHitSmoke", objNull];
    if (!isNull _smoke) then {
        deleteVehicle _smoke;
    };
}, {
    hint "Failure!"
}, "Repairing Critical Damage"] call ace_common_fnc_progressBar;