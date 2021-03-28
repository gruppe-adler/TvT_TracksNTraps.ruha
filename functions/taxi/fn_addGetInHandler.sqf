params ["_veh"];

_veh setVariable ["gradTnT_isTaxi", true, true];

[_veh] remoteExecCall ["gradTnT_fnc_addInteraction", 0, true];
[_veh] spawn gradTnT_bft_fnc_add;


[{
        params ["_veh"];
        count (crew _veh) < 2 && alive driver _veh && !isPlayer driver _veh && _veh getVariable ["gradTnT_taxiMarker", ""] != ""

    }, 
    {
        params ["_veh"];
        private _driverGroup = (group driver _veh);

        for "_i" from count waypoints _driverGroup - 1 to 0 step -1 do
        {
            deleteWaypoint [_driverGroup, _i];
        };

        private _position = _veh getVariable ["gradTnT_taxiSpawnPosition", [0,0,0]];
        private _wp = _driverGroup addWaypoint [_position, 0];
        _wp setWaypointStatements ["true", "
            private _vehicle = vehicle this;
            private _side = side _vehicle;
            deleteVehicle _vehicle;
            { deleteVehicle _x; } forEach thisList;
            ['gradTnT_points', ['car_deposit', [_side] call gradTnT_fnc_getOpposingSide]] call CBA_fnc_serverEvent;
        "];

        _driverGroup setSpeedMode "FULL";
        _veh limitSpeed 7;

        [{
            params ["_veh"];
            count (nearestObjects [_veh, ["Man"], 20]) < 1

        }, {
            params ["_veh"];

            _veh limitSpeed 100;
        }, [_veh]] call CBA_fnc_waitUntilAndExecute;
}, [_veh]] call CBA_fnc_waitUntilAndExecute;


_veh addEventHandler ["GetIn", {
    _veh = _this select 0;
    _unit = _this select 2;

    _owner = _veh getVariable ["TnT_taxiOwner", objNull];

    if (isNull _owner && isPlayer _unit) then {
        _veh setVariable ["TnT_taxiOwner", _unit];
        [_owner, _veh] remoteExec ["gradTnT_fnc_taxiDialogOpen", _unit, false];
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