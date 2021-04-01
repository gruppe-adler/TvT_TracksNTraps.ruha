params ["_vehicle", "_sign"];

if (!isServer) exitWith {
    [_vehicle, _sign] remoteExec ["gradTnT_callsign_fnc_addCustomFormationSign", 2];
};

private _hiddenSelections = getArray(configfile >> "CfgVehicles" >> typeOf _vehicle >> "hiddenSelections");
private _selectionName = "Insignia_formation";

_vehicle setObjectTextureGlobal [_hiddenSelections find _selectionName, _sign];


// nation sign
private _selectionNameNation = "Insignia_nation_01";
private _textureNationOpfor = "gm\gm_core\gm_core_vehicles\data\systems\vehiclemarkings\insignias\nations\gm_ur_star_01_ca.paa";
private _textureNationBlufor = "gm\gm_core\gm_core_vehicles\data\systems\vehiclemarkings\insignias\nations\gm_ge_army_01_ca.paa";

if (_vehicle getVariable ["gradTnT_vehicleSide", sideUnknown] == west) then {
    _vehicle setObjectTextureGlobal [_hiddenSelections find _selectionNameNation, _textureNationBlufor];
} else {
    _vehicle setObjectTextureGlobal [_hiddenSelections find _selectionNameNation, _textureNationOpfor];
};