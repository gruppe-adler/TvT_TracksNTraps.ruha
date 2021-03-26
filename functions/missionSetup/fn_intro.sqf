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