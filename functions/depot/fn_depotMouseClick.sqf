private _depotDummys = player getVariable ["gradTnT_carrydepotDummys", []];

/*
    gradTnT_carryDepot
    -1 abort/default
    1 walking with bridge
    2 place signal

*/

(_depotDummys select 0) params ["_depotDummy", "_relPos", "_offsetDir"];

// communication is in fnc_depotplace PFH
if ((_this select 1) == 0) then {
    if (!(surfaceIsWater position _depotDummy)) then {
        player setVariable ["gradTnT_carryDepot", 2];
        diag_log format ["placing %1", _depotDummy];
    };
};


if ((_this select 1) == 1) then {
    player setVariable ["gradTnT_carryDepot", -1];
};