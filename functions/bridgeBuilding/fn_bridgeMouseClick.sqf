private _bridgeDummy = player getVariable ["gradSB_carryBridge", objNull];

// communication is in fnc_bridgeplace PFH
if (surfaceIsWater position _bridgeDummy) then {
  if ((_this select 1) == 0) then {
    player setVariable ["gradSB_carryBridge", objNull];
  };
};
