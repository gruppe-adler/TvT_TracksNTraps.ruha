gradTnT_DEPOTS_MAX = 1; // maximum an engineer can build before he has to destroy them again
gradTnT_DEPOTS_VEHICLE_WEST = "gm_ge_army_marder1a2";
gradTnT_DEPOTS_VEHICLE_EAST = "gm_gc_army_bmp1sp2"; // empty string to allow placement everywhere, else its only allowed near on of the listed vehicles
gradTnT_DEPOTS_VEHICLE_DISTANCE = 30; // maximum distance vehicle is allowed to be


if (player getVariable ["ACE_IsEngineer", 0] > 0) then {
    call gradTnT_fnc_depotActionDeploy;
};