["CBA_loadingScreenDone", {
    _waitCondition = {time > (_this + 20)};



    
    [_waitCondition,{

        playSound "intro_fx";
        [2,2,false] call gradTnT_fnc_showGlitchLogo;

        [{
            [0.1,2,true] call gradTnT_fnc_showGlitchLogo;
        }, [], 5.5] call CBA_fnc_waitAndExecute;

    },time] call CBA_fnc_waitUntilAndExecute;
    

}] call CBA_fnc_addEventHandler;


// empty fuel on all vehicles
if (isServer) then {
    {
       [_x, 0] remoteExec ["setFuel", _x];
    } forEach vehicles;
};

// prevent bugging out on jip
[{
    !isNil "PREPARATION_TIME"  
},{
        // start replay record on server and init replay on client
    [{
        call GRAD_replay_fnc_init;

        // fill all vehicles with fuel after prep time
        if (isServer) then {
            {
               [_x, 1] remoteExec ["setFuel", _x];
            } forEach vehicles;
        };

    }, [], PREPARATION_TIME] call CBA_fnc_waitAndExecute;    
}, []] call CBA_fnc_waitUntilAndExecute;


/*
// moved to vehicle inventory
if (player getVariable ["ACE_isEngineer", 0] > 0 && side player == west) then {
    [player,"land_gm_tanktrap_01",15] call grad_fortifications_fnc_addFort;
};

if (player getVariable ["ACE_isEngineer", 0] > 0 && side player == east) then {
    [player,"land_gm_tanktrap_02",15] call grad_fortifications_fnc_addFort;
};
*/
