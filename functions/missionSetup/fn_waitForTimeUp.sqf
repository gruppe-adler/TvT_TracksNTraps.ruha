if (!isServer) exitWith {};

[{
    call BIS_fnc_missionTimeLeft < 0.1
},{
    remoteExec ["gradTnT_fnc_showStats", 0];
}, []] call CBA_fnc_waitUntilAndExecute;