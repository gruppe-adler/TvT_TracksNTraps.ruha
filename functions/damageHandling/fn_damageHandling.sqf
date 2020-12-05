params ["_vehicle"];

if (_vehicle isKindOf "Tank") then {
    _vehicle addEventHandler ["HandleDamage", {
        params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

        // prevent damage explosions
        if ((_damage > .88 && _hitPoint == "hitHull") || (_damage > .88 && _hitPoint == "") || damage _unit > .88) then {
            _damage = .88;

            if (!(_unit getVariable ["gradTnT_criticalHit", false])) then {
                _unit setVariable ["gradTnT_criticalHit", true, true];
                private _smoke = createVehicle ["test_EmptyObjectForSmoke", getPos _unit, [], 0, "NONE"];
                _smoke attachTo [_unit, [0,0,-1]];
                _unit setVariable ["gradTnT_criticalHitSmoke", _smoke, true];
            };
        };

        // hint ("damage is " + str _damage + " - hitpoint is " + str _hitPoint);
        // diag_log format ["damage %1 - hitpoint %2 - vehicle alive %3", _damage, _hitPoint, alive _unit];
        
        _damage
    }];

    [_vehicle] call gradTnT_fnc_damageHandlingAddAction;
};
