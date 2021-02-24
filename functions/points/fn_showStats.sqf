/*

    execVM "functions\points\fn_showStats.sqf";

*/



if (isServer) then {
    [] spawn {
        private _resultInf_west = str (([west, "Players killed"] call grad_points_fnc_getPointsCategory) + ([west, "AI killed"] call grad_points_fnc_getPointsCategory));
        private _resultInf_east = str (([east, "Players killed"] call grad_points_fnc_getPointsCategory) + ([east, "AI killed"] call grad_points_fnc_getPointsCategory));
        private _resultInf_independent = str (([independent, "Players killed"] call grad_points_fnc_getPointsCategory) + ([independent, "AI killed"] call grad_points_fnc_getPointsCategory));
        private _resultInf_civilian = str (([civilian, "Players killed"] call grad_points_fnc_getPointsCategory) + ([civilian, "AI killed"] call grad_points_fnc_getPointsCategory));
        // private _resultArmored = ["", "1", "2", "3", "4"];

        private _resultSoft_west = str ([west, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
        private _resultSoft_east = str ([east, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
        private _resultSoft_independent = str ([independent, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
        private _resultSoft_civilian = str ([civilian, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
        // private _resultArmored = ["", "1", "2", "3", "4"];
        private _resultFuel_west = format ["%1", [west] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
        private _resultFuel_east = format ["%1", [east] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
        private _resultFuel_independent = format ["%1", [independent] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
        private _resultFuel_civilian = format ["%1", [civilian] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];

        private _resultTotalNumber_west = [((parseNumber _resultInf_west) + (parseNumber _resultSoft_west) + (parseNumber _resultFuel_west)), west];
        private _resultTotalNumber_east = [((parseNumber _resultInf_east) + (parseNumber _resultSoft_east) + (parseNumber _resultFuel_east)), east];
        private _resultTotalNumber_independent = [((parseNumber _resultInf_independent) + (parseNumber _resultSoft_independent) + (parseNumber _resultFuel_independent)), independent];
        private _resultTotalNumber_civilian = [((parseNumber _resultInf_civilian) + (parseNumber _resultSoft_civilian) + (parseNumber _resultFuel_civilian)), civilian];

        _resultTotalNumber_west params ["_resultTotal_west"];
        _resultTotalNumber_east params ["_resultTotal_east"];
        _resultTotalNumber_independent params ["_resultTotal_independent"];
        _resultTotalNumber_civilian params ["_resultTotal_civilian"];

        private _results_west = ["", _resultInf_west, _resultSoft_west, _resultFuel_west, str _resultTotal_west];
        private _results_east = ["", _resultInf_east, _resultSoft_east, _resultFuel_east, str _resultTotal_east];
        private _results_independent = ["", _resultInf_independent, _resultSoft_independent, _resultFuel_independent, str _resultTotal_independent];
        private _results_civilian = ["", _resultInf_civilian, _resultSoft_civilian, _resultFuel_civilian, str _resultTotal_civilian];

        private _totalNumbers = [_resultTotalNumber_west, _resultTotalNumber_east, _resultTotalNumber_independent, _resultTotalNumber_civilian];
        _totalNumbers sort false;

        diag_log ("total numbers server: " + str _totalNumbers);

        private _winner = _totalNumbers select 0 select 1;
        private _draw = _resultTotal_west isEqualTo _resultTotal_east &&
                        _resultTotal_independent isEqualTo _resultTotal_civilian &&
                        _resultTotal_west isEqualTo _resultTotal_civilian;
        
        diag_log ("draw is: " + str _draw);
        diag_log ("winner is: " + str _winner);
        sleep 16;
        [] call GRAD_replay_fnc_stopRecord;

        if (!_draw) then {
            switch (_winner) do { 
                case west : { [[west]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];  }; 
                case east : {  [[east]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];  }; 
                case independent : { [[independent]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];   }; 
                case civilian : {  [[civilian]] remoteExec ["grad_endings_fnc_endMissionClient",0,false]; }; 
                default {}; 
            };
        } else {
            [[west,east,independent,civilian]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];
        };
    };
};


if (hasInterface) then {

    playSound "glitch_end";
    [player, true] call TFAR_fnc_forceSpectator;
    [player, player] call ace_medical_treatment_fnc_fullHeal;


    private _screenWidth = safeZoneW;
    private _screenHeight = safeZoneH;

    private _columnWidth = _screenWidth/40;
    private _rowHeight = _screenHeight/40;

    disableSerialization;

    // private _iconKilled = "\A3\ui_f\data\igui\cfg\mptable\killed_ca.paa";
    private _iconInf = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
    private _iconSoft = "\A3\ui_f\data\igui\cfg\mptable\soft_ca.paa";
    // private _iconArmored = "\A3\ui_f\data\igui\cfg\mptable\armored_ca.paa";
    private _iconFuel = "USER\winstats\drop2.paa";
    private _iconTotal = "\A3\ui_f\data\igui\cfg\mptable\total_ca.paa";
    // text = "\A3\ui_f\data\igui\cfg\mptable\air_ca.paa";

    private _columns = ["", "Russen", "Italiener", "Chinesen"];
    private _picturePath = ["", _iconInf, _iconSoft, _iconFuel, _iconTotal];
    private _picturePathDescription = ["", "Infanterie", "Autos", "Treibstoff", "Insgesamt"];

    private _resultInf_west = str (([west, "Players killed"] call grad_points_fnc_getPointsCategory) + ([west, "AI killed"] call grad_points_fnc_getPointsCategory));
    private _resultInf_east = str (([east, "Players killed"] call grad_points_fnc_getPointsCategory) + ([east, "AI killed"] call grad_points_fnc_getPointsCategory));
    private _resultInf_independent = str (([independent, "Players killed"] call grad_points_fnc_getPointsCategory) + ([independent, "AI killed"] call grad_points_fnc_getPointsCategory));
    
    // private _resultArmored = ["", "1", "2", "3", "4"];

    private _resultSoft_west = str ([west, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
    private _resultSoft_east = str ([east, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
    private _resultSoft_independent = str ([independent, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory);
    
    // private _resultArmored = ["", "1", "2", "3", "4"];
    private _resultFuel_west = format ["%1", [west] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
    private _resultFuel_east = format ["%1", [east] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
    private _resultFuel_independent = format ["%1", [independent] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
    
    

    private _resultTotalNumber_west = [((parseNumber _resultInf_west) + (parseNumber _resultSoft_west) + (parseNumber _resultFuel_west)), west];
    private _resultTotalNumber_east = [((parseNumber _resultInf_east) + (parseNumber _resultSoft_east) + (parseNumber _resultFuel_east)), east];
    private _resultTotalNumber_independent = [((parseNumber _resultInf_independent) + (parseNumber _resultSoft_independent) + (parseNumber _resultFuel_independent)), independent];
    

    _resultTotalNumber_west params ["_resultTotal_west"];
    _resultTotalNumber_east params ["_resultTotal_east"];
    _resultTotalNumber_independent params ["_resultTotal_independent"];
    _resultTotalNumber_civilian params ["_resultTotal_civilian"];

    private _results_west = ["", _resultInf_west, _resultSoft_west, _resultFuel_west, str _resultTotal_west];
    private _results_east = ["", _resultInf_east, _resultSoft_east, _resultFuel_east, str _resultTotal_east];
    private _results_independent = ["", _resultInf_independent, _resultSoft_independent, _resultFuel_independent, str _resultTotal_independent];
    

    private _totalNumbers = [_resultTotalNumber_west, _resultTotalNumber_east, _resultTotalNumber_independent];
    _totalNumbers sort false;

    // hint str _totalNumbers;

    private _winner = _totalNumbers select 0 select 1;
    private _draw = _resultTotal_west isEqualTo _resultTotal_east &&
                    _resultTotal_independent isEqualTo _resultTotal_west;
                    

    private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

    _display displayAddEventHandler ["KeyDown", "if (((_this select 1) == 1) && (!isServer)) then {true} else {false};"];


    private _resultText = "Draw!";
    if (!_draw) then {
        switch (_winner) do { 
            case west : { _resultText = "Russ. Mafia wins";  }; 
            case east : {  _resultText = "Ital. Mafia wins";  }; 
            case independent : { _resultText = "Chin. Mafia wins";   };
            default {}; 
        };
    };

    private _background = _display ctrlCreate ["RscText", -1];
    _background ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _screenHeight];
    _background ctrlSetBackgroundColor [0,0,0,0.9];
    _background ctrlCommit 0;

    private _backgroundHeader = _display ctrlCreate ["RscText", -1];
    _backgroundHeader ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*4];
    _backgroundHeader ctrlSetBackgroundColor [0,0,0,1];
    _backgroundHeader ctrlCommit 0;

    private _bgHeadline = _display ctrlCreate ["RscStructuredText", -1];
    _bgHeadline ctrlsetFont "RobotoCondensedBold";
    _bgHeadline ctrlSetBackgroundColor [0,0,0,0];
    _bgHeadline ctrlSetStructuredText parseText ("<t size='3' align='center' color='#333333'>" + _resultText + "</t>");
    _bgHeadline ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*3];
    _bgHeadline ctrlCommit 0;




    for "_i" from 1 to 5 do {

        private _multiplicator = _i * 5;

        private _column = _display ctrlCreate ["RscText", -1];
        _column ctrlSetPosition [
            _columnWidth * _multiplicator + safezoneX + _columnWidth,
            _rowHeight + safezoneY,
            _columnWidth * 4,
            _screenHeight + safezoneY
        ];
        _column ctrlSetBackgroundColor [1,1,1,0];
        _column ctrlCommit 0;

        private _headline = _display ctrlCreate ["RscStructuredText", -1];
        _headline ctrlsetFont "RobotoCondensedBold";
        _headline ctrlSetBackgroundColor [0,0,0,0];
        _headline ctrlSetTextColor [1,1,1,1];
        _headline ctrlSetStructuredText parseText ("<t size='2' align='center' color='#666666'>" + (_columns select (_i-1)) + "</t>");
        _headline ctrlSetPosition [
            _columnWidth * _multiplicator + safezoneX + _columnWidth,
            _rowHeight * 4 + safezoneY + _rowHeight * 2,
            _columnWidth * 4,
            _rowHeight * 2.5
        ];
        _headline ctrlCommit 0;


        for "_j" from 1 to 4 do {

                private _textFadeResult = if (_j == 4) then { 0 } else { 0.5 };

                if (_i == 1) then {
                    private _picture = _display ctrlCreate ["RscPictureKeepAspect", -1];
                    _picture ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth + _columnWidth/2,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 2,
                        _rowHeight * 2
                    ];
                    _picture ctrlSetBackgroundColor [0,0,0,0];
                    _picture ctrlSetText (_picturePath select _j);
                    _picture ctrlSetTooltip (_picturePathDescription select _j);
                    _picture ctrlSetFade 0.5;
                    _picture ctrlCommit 0;
                };

                if (_i == 2) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + (_results_west select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 4,
                        _rowHeight * 2
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };

                if (_i == 3) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + (_results_east select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 4,
                        _rowHeight * 2
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };

                if (_i == 4) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + (_results_independent select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 4,
                        _rowHeight * 2
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };


                private _dividerHeight = if (_j == 4) then { _rowHeight/10 } else { _rowHeight/20 };
                private _divider = _display ctrlCreate ["RscStructuredText", -1];
                _divider ctrlSetPosition [
                    safezoneX,
                    (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 4,
                    _screenWidth,
                    _dividerHeight
                ];
                _divider ctrlSetBackgroundColor [1,1,1,0.03];
                _divider ctrlCommit 0;
        };
    };

    sleep 16;
    _display displayRemoveAllEventHandlers "KeyDown";
    _display closeDisplay 1;

};
