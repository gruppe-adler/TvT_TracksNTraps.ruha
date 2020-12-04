params ["_unit", "_bridge"];

private _maxTime = 30;

for "_i" from 0 to _maxTime do {
  [{
      params ["_i", "_unit"];

      private _string = format ["Bridge blows up in %1 s...", _i];

      [_string] remoteExec ["hintSilent", _unit];

  }, [(_maxTime-_i), _unit], _i] call CBA_fnc_waitAndExecute;
};


[{
    params ["_bridge", "_unit"];

    "Bo_GBU12_LGB" createVehicle (position _bridge);
    deleteVehicle _bridge;

    private _bridgesBuild = _unit getVariable ["SB_bridgesBuilt", 0];
    if (_bridgesBuild > 0) then {
        _bridgesBuild = _bridgesBuild - 1;
    };
    _unit setVariable ["SB_bridgesBuilt", _bridgesBuild, true];

    private _bridgesLeft = format ["You can now build %1 bridge again.", 2 - _bridgesBuild];
    [_bridgesLeft] remoteExec ["hintSilent", _unit];

}, [_bridge, _unit], _maxTime] call CBA_fnc_waitAndExecute;
