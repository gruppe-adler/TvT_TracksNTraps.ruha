gradTnT_DEPOTS_MAX = 1; // maximum an engineer can build before he has to destroy them again
gradTnT_DEPOTS_VEHICLE_DISTANCE = 30; // maximum distance vehicle is allowed to be


if (player getVariable ["ACE_IsEngineer", 0] > 0) then {
    [{
        player getVariable ["gradTnT_engineerNodeAdded", false]
    },{
        call gradTnT_fnc_depotActionDeploy;
    }, []] call CBA_fnc_waitUntilAndExecute; 
};