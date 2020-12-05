SB_DEPOTS_MAX = 1; // maximum an engineer can build before he has to destroy them again
SB_DEPOTS_VEHICLE_WEST = "gm_ge_army_bpz2a0";
SB_DEPOTS_VEHICLE_EAST = "gm_gc_army_ural44202"; // empty string to allow placement everywhere, else its only allowed near on of the listed vehicles
SB_DEPOTS_VEHICLE_DISTANCE = 30; // maximum distance vehicle is allowed to be


{
    private _unit = _x;

    if (_unit getVariable ["ACE_IsEngineer", 0] > 0) then {
        [] remoteExecCall ["gradTnT_fnc_depotActionDeploy", _unit, true];
    };
} forEach (playableUnits + switchableUnits);
