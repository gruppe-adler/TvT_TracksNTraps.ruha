private _depotDummys = player getVariable ["gradTnT_carrydepotDummys", []];

/*
    gradTnT_carryDepot
    -1 abort/default
    1 walking with bridge
    2 place signal

*/


// communication is in fnc_bridgeplace PFH
if (surfaceIsWater position (_depotDummy select 0)) then {
  if ((_this select 1) == 0) then {
    player setVariable ["gradTnT_carryDepot", 2];
  };
};

if ((_this select 1) == 1) then {
    player setVariable ["gradTnT_carryDepot", -1];
};