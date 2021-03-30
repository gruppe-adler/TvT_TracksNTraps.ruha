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

    private _helper = _bridge getVariable ["gradTnT_bridgeHelper", objNull];
    if (!isNull _helper) then {
      deleteVehicle _helper;
    };


    "Bo_GBU12_LGB" createVehicle (position _bridge);

    // bridge has no destruct state, therefore we move it below ground and do fake damage for BFT compliance
    _bridge setDamage 1;
    private _position = getPos _bridge;
    _position set [2, ((_position select 2) -20)];
    _bridge setPos _position;

    private _bridgesBuild = _unit getVariable ["SB_bridgesBuilt", 0];
    if (_bridgesBuild > 0) then {
        _bridgesBuild = _bridgesBuild - 1;
    };
    _unit setVariable ["SB_bridgesBuilt", _bridgesBuild, true];

    private _bridgesLeft = format ["You can now build %1 bridge again.", 2 - _bridgesBuild];
    [_bridgesLeft] remoteExec ["hintSilent", _unit];

}, [_bridge, _unit], _maxTime] call CBA_fnc_waitAndExecute;
