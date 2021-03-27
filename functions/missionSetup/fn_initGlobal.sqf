["CBA_loadingScreenDone", {
    _waitCondition = {time > (_this + 3)};

    [_waitCondition,{
        private _text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='pics\logo_large_glitch.paa'/>"];
        [_text,0,0,2,2] spawn BIS_fnc_dynamicText;

        playSound "intro_fx";

        [{
            private _text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='pics\logo_large_noglitch.paa'/>"];
            [_text,0,0,1,1] spawn BIS_fnc_dynamicText;
        }, [], 5.5] call CBA_fnc_waitAndExecute;

    },time] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_addEventHandler;


// prevent bugging out on jip
[{
    !isNil "PREPARATION_TIME"  
},{
        // start replay record on server and init replay on client
    [{
        call GRAD_replay_fnc_init;
    }, [], PREPARATION_TIME] call CBA_fnc_waitAndExecute;    
}, []] call CBA_fnc_waitUntilAndExecute;


if (player getVariable ["ACE_isEngineer", 0] > 0 && side player == west) then {
    [player,"land_gm_tanktrap_01",15] call grad_fortifications_fnc_addFort;
};

if (player getVariable ["ACE_isEngineer", 0] > 0 && side player == east) then {
    [player,"land_gm_tanktrap_02",15] call grad_fortifications_fnc_addFort;
};