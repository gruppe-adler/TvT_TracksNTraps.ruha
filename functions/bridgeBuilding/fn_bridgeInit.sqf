/*

  adds actions to bridge builders

*/

SB_BRIDGES_MAX = 2; // maximum an engineer can build before he has to destroy them again
SB_BRIDGES_VEHICLE_DISTANCE = 30; // maximum distance vehicle is allowed to be


if (player getVariable ["ACE_IsEngineer", 0] > 0) then {
    [{
        player getVariable ["gradTnT_engineerNodeAdded", false]
    },{
        call gradTnT_fnc_bridgeActionBuild;
    }, []] call CBA_fnc_waitUntilAndExecute; 
};