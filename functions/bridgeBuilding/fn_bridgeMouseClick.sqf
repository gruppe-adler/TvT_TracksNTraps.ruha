private _bridgeDummy = player getVariable ["gradSB_carryBridgeDummy", objNull];

/*
    gradSB_carryBridge
    -1 abort/default
    1 walking with bridge
    2 place signal

*/


// communication is in fnc_bridgeplace PFH
if (surfaceIsWater position _bridgeDummy) then {
  if ((_this select 1) == 0) then {
    player setVariable ["gradSB_carryBridge", 2];
  };
};

if ((_this select 1) == 1) then {
    player setVariable ["gradSB_carryBridge", -1];
};