if (!isServer) exitWith {};

[{
    call BIS_fnc_missionTimeLeft < 1 && call BIS_fnc_missionTimeLeft > -1
},{
    remoteExec ["gradTnT_fnc_showStats", 0];


    [{
        [] call GRAD_replay_fnc_stopRecord;
    }, [], 10] call CBA_fnc_waitAndExecute;

}, []] call CBA_fnc_waitUntilAndExecute;