params ["_helper", "_unit"];


private _maxTime = 15;

for "_i" from 0 to _maxTime do {
  [{
      params ["_i", "_unit"];

      private _string = format ["Bridge blows up in %1 s...", _i];

      if (_i < 1) then {
          _string = "";
      };

      [_string] remoteExec ["hintSilent", _unit];

  }, [(_maxTime-_i), _unit], _i] call CBA_fnc_waitAndExecute;
};


[{
    params ["_helper", "_unit"];

    "Bo_GBU12_LGB" createVehicle (position _helper);

    private _bridges = _helper getVariable ["gradTnT_connectedBridges", []];

    {
        _x setDamage 1;
    } forEach _bridges;


    _helper setVariable ["gradTnT_bridgeDestroyed", true, true];

    [_helper, true] remoteExecCall ["hideObjectGlobal", 2];

}, [_helper, _unit], _maxTime] call CBA_fnc_waitAndExecute;