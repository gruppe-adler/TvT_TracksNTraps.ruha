["gradTnT_points", {
    params ["_type", "_side"];

    private _pointsAdded = 0;
    private _history = missionNamespace getVariable ["gradTnT_pointHistory", []];

    switch (_type) do {
        private _cfg = missionConfigFile >> "gradTnT_Points";

        case "flagTick" : {
           _pointsAdded = [_cfg,"flagTick",100] call BIS_fnc_returnConfigEntry;
        };
        case "depotTick" : {
           _pointsAdded = [_cfg,"depotTick",100] call BIS_fnc_returnConfigEntry;
        };
        case "depot" : {
            _pointsAdded = [_cfg,"depot",2000] call BIS_fnc_returnConfigEntry;
        };
        case "bridge" : {
            _pointsAdded = [_cfg,"bridge",1000] call BIS_fnc_returnConfigEntry;
        };
        case "tank" : {
            _pointsAdded = [_cfg,"tank",500] call BIS_fnc_returnConfigEntry;
        };
        case "apc" : {
            _pointsAdded = [_cfg,"apc",300] call BIS_fnc_returnConfigEntry;
        };
        case "car" : {
            _pointsAdded = [_cfg,"car",300] call BIS_fnc_returnConfigEntry;
        };
        case "crew" : {
            _pointsAdded = [_cfg,"crew",50] call BIS_fnc_returnConfigEntry;
        };
        case "car_deposit" : {
            _pointsAdded = [_cfg,"car_deposit",-50] call BIS_fnc_returnConfigEntry;
        };
        default {};
    };

    private _pointsKey = format ["gradTnT_points_%1", _side];
    private _pointsExisting = missionNameSpace getVariable [_pointsKey, 0];
    private _newTotal = _pointsExisting + _pointsAdded;
    missionNameSpace setVariable [_pointsKey, _newTotal, true];

    // save with timestamp for later evaluation
    _history pushBack [_newTotal, _side, CBA_missionTime];
    missionNamespace setVariable ["gradTnT_pointHistory", _history, true];

    diag_log format ["%1 - new points for %2: %3 for type %4", CBA_missionTime, _side, _newTotal, _type];

}] call CBA_fnc_addEventHandler;