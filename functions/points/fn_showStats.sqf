/*

    execVM "functions\points\fn_showStats.sqf";

*/
/*
case "flagTick" : {
           _pointsAdded = [_cfg,"flagTick",100] call BIS_fnc_returnConfigEntry;
        };
        case "depotTick" : {
           _pointsAdded = [_cfg,"depotTick",100] call BIS_fnc_returnConfigEntry;
        };
        case "depot" : {
            _pointsAdded = [_cfg,"depot",2000] call BIS_fnc_returnConfigEntry;
        };
        case "bridge" : {
            _pointsAdded = [_cfg,"bridge",1000] call BIS_fnc_returnConfigEntry;
        };
        case "tank" : {
            _pointsAdded = [_cfg,"tank",500] call BIS_fnc_returnConfigEntry;
        };
        case "apc" : {
            _pointsAdded = [_cfg,"apc",300] call BIS_fnc_returnConfigEntry;
        };
        case "car" : {
            _pointsAdded = [_cfg,"car",300] call BIS_fnc_returnConfigEntry;
        };
        case "crew" : {
            _pointsAdded = [_cfg,"crew",50] call BIS_fnc_returnConfigEntry;
        };

         private _pointsKey = format ["gradTnT_points_%1", _side];
    private _pointsExisting = missionNameSpace getVariable [_pointsKey, 0];
        */

if (isServer) then {
    [] spawn {
        
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

    private _columns = ["", "Blufor", "Opfor"];
    private _picturePath = ["", _iconInf, _iconSoft, _iconFuel, _iconTotal];
    private _picturePathDescription = ["", "Infanterie", "Autos", "Treibstoff", "Insgesamt"];


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
            case west : { _resultText = "Blufor wins";  }; 
            case east : {  _resultText = "Opfor wins";  }; 
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
