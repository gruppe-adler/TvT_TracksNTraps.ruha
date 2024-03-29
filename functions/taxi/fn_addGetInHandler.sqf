params ["_veh"];

_veh setVariable ["gradTnT_isTaxi", true, true];

[_veh] spawn gradTnT_bft_fnc_add;
[_veh] remoteExecCall ["gradTnT_fnc_addInteraction", 0, true];

_veh addEventHandler ["GetIn", {
    _veh = _this select 0;
    _unit = _this select 2;

    _owner = _veh getVariable ["TnT_taxiOwner", objNull];

    if (isNull _owner && isPlayer _unit) then {
        _veh setVariable ["TnT_taxiOwner", _unit];
    };

}];

_veh addEventHandler ["GetOut", {
    _veh = _this select 0;
    _unit = _this select 2; 

    _owner = _veh getVariable ["TnT_taxiOwner", objNull];

    if (str _unit == str _owner) then {
        _veh setVariable ["TnT_taxiOwner", objNull];
    };

}];