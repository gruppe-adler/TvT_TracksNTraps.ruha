params ["_vehicle", "_number", "_font"];

if (!isServer) exitWith {
    [_vehicle, _number] remoteExec ["gradTnT_callsign_fnc_addCustomNumber", 2];
};

private _selections = ["nr_1","nr_2","nr_3","nr_4"];

[_vehicle, _font, _number, _selections] call gm_core_fnc_setDigitTexture;

_vehicle setVariable ["gradTnT_customNumber", _number, true];