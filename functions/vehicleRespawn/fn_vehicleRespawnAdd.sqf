// SERVER CODE
if ( ! ( isServer ) ) exitWith {};

params ["_vehObj", ["_respawnWhenNotDead", true], ["_loopInterval", 5]];

private _customCode = [(missionConfigFile >> "gradSB_vehicleRespawn"), typeOf _vehObj, ""] call BIS_fnc_returnConfigEntry;

// STORE THE VEHICLES DIRECTION, POSITION AND TYPE
private _vehDir =       getDir _vehObj;
private _vehPos =       getPos _vehObj;
private _vehType =      typeOf _vehObj;
private _displayName =  getText(configFile >> "CfgVehicles" >> _vehType >> "displayName");
private _gmAttributes = _vehObj getVariable ["gm_vehicle_attributes", []];

diag_log format ["grad-vehicleRespawn: adding %1 to respawn, respawns when not dead: %2", _displayName, _respawnWhenNotDead];

[{
    params ["_args", "_handle"];
    _args params ["_vehObj", "_respawnWhenNotDead", "_vehType", "_vehDir", "_vehPos", "_displayName", "_customCode", "_gmAttributes"];

    // if object is deleted, respawn replacement anyway
    if (isNull _vehObj) exitWith {
            [_vehType, _respawnWhenNotDead, _vehDir, _vehPos, _handle, _customCode, _gmAttributes] call gradSB_fnc_vehicleRespawnCheck;
    };


    // diag_log format ["checking %1 for respawn", _displayName];
    if (
            _respawnWhenNotDead &&
            { ( alive _vehObj ) }
        ) exitWith {

            diag_log format ["grad-vehicleRespawn: checking vehicle %1 for respawn", _vehObj];
            [_vehType, _respawnWhenNotDead, _vehDir, _vehPos, _handle, _customCode, _gmAttributes] call gradSB_fnc_vehicleRespawnCheck;
    };

    if ( !( alive _vehObj ) ) exitWith {

            diag_log format ["grad-vehicleRespawn: vehicle %1 dead", _vehObj];
            [_vehType, _respawnWhenNotDead, _vehDir, _vehPos, _handle, _customCode, _gmAttributes] call gradSB_fnc_vehicleRespawnCheck;
    };

}, _loopInterval, [_vehObj, _respawnWhenNotDead, _vehType, _vehDir, _vehPos, _displayName, _customCode, _gmAttributes]] call CBA_fnc_addPerFrameHandler;
