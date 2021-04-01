params ["_vehicle", "_sign"];

if (!isServer) exitWith {
    [_vehicle, _sign] remoteExec ["gradTnT_callsign_fnc_addCustomFormationSign", 2];
};

private _hiddenSelections = getArray(configfile >> "CfgVehicles" >> typeOf _vehicle >> "hiddenSelections");
private _selectionName = "Insignia_formation";

_vehicle setObjectTextureGlobal [_hiddenSelections find _selectionName, _sign];