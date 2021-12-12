/*

    [false] execVM "functions\points\fn_showStats.sqf";

*/

params [["_playSound", true]];

gradTnT_fnc_getPointsForKeySide = {
    params ["_side", "_type"];

    private _pointsKey = format ["gradTnT_points_%1_%2", _side, _type];
    private _pointsExisting = missionNameSpace getVariable [_pointsKey, 0];
    
    _pointsExisting
};

gradTnT_fnc_getPointsForSide = {
    params ["_side"];

    private _pointsTotalKey = format ["gradTnT_pointsTotal_%1", _side];
    private _pointsTotalExisting = missionNameSpace getVariable [_pointsTotalKey, 0];
    
    _pointsTotalExisting
};


private _flagTickWest = [west, "flagTick"] call gradTnT_fnc_getPointsForKeySide;
// private _depotTickWest = [west, "depotTick"] call gradTnT_fnc_getPointsForKeySide;
private _depotWest = [west, "depot"] call gradTnT_fnc_getPointsForKeySide;
private _bridgeWest = [west, "bridge"] call gradTnT_fnc_getPointsForKeySide;
private _tankWest = [west, "tank"] call gradTnT_fnc_getPointsForKeySide;
private _apcWest = [west, "apc"] call gradTnT_fnc_getPointsForKeySide;
private _carWest = [west, "car"] call gradTnT_fnc_getPointsForKeySide;
private _crewWest = [west, "crew"] call gradTnT_fnc_getPointsForKeySide;
      
private _flagTickEast = [east, "flagTick"] call gradTnT_fnc_getPointsForKeySide;
// private _depotTickEast = [east, "depotTick"] call gradTnT_fnc_getPointsForKeySide;
private _depotEast = [east, "depot"] call gradTnT_fnc_getPointsForKeySide;
private _bridgeEast = [east, "bridge"] call gradTnT_fnc_getPointsForKeySide;
private _tankEast = [east, "tank"] call gradTnT_fnc_getPointsForKeySide;
private _apcEast = [east, "apc"] call gradTnT_fnc_getPointsForKeySide;
private _carEast = [east, "car"] call gradTnT_fnc_getPointsForKeySide;
private _crewEast = [east, "crew"] call gradTnT_fnc_getPointsForKeySide;



private _results_west_total = [west] call gradTnT_fnc_getPointsForSide;
private _results_east_total = [east] call gradTnT_fnc_getPointsForSide;

private _results_west = [nil, _flagTickWest, _depotWest, _bridgeWest, _tankWest, _apcWest, _carWest, _crewWest, _results_west_total];
private _results_east = [nil, _flagTickEast, _depotEast, _bridgeEast, _tankEast, _apcEast, _carEast, _crewEast, _results_east_total];

if (hasInterface) then {

    if (_playSound) then {
        playSound "intro_fx";
    
        [player, true] call TFAR_fnc_forceSpectator;
        [player, player] call ace_medical_treatment_fnc_fullHeal;
    };

    private _screenWidth = safeZoneW;
    private _screenHeight = safeZoneH;

    private _columnWidth = _screenWidth/30;
    private _rowHeight = _screenHeight/60;

    disableSerialization;

    private _iconObjective = "\A3\ui_f\data\Map\Markers\HandDrawn\flag_ca.paa";
    private _iconDepots = "functions\bft\data\depot.paa";
    private _iconBridges = "functions\bft\data\bridge.paa";
    private _iconArmored = "functions\bft\data\armor.paa";
    private _iconAPC = "\A3\ui_f\data\Map\Vehicleicons\iconAPC_ca.paa";
    private _iconCar = "\A3\ui_f\data\Map\Vehicleicons\iconCar_ca.paa";
    private _iconInf = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
    private _iconTotal = "\A3\ui_f\data\igui\cfg\mptable\total_ca.paa";
    // text = "\A3\ui_f\data\igui\cfg\mptable\air_ca.paa";

    private _columns = ["", "Blufor", "Opfor"];
    private _picturePath = ["", _iconObjective, _iconDepots, _iconBridges, _iconArmored, _iconAPC, _iconCar, _iconInf, _iconTotal];
    private _picturePathDescription = ["", "Objective", "Depots", "Bridges", "Tank", "APC", "Cars", "Crew", "Total"];


    private _totalNumbers = [[_results_west_total, west], [_results_east_total, east]];
    _totalNumbers sort false;

    // hint str _totalNumbers;

    private _winner = _totalNumbers select 0 select 1;
    private _draw = _results_west_total isEqualTo _results_east_total;
                    

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
    _bgHeadline ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*5];
    _bgHeadline ctrlCommit 0;




    for "_i" from 1 to 3 do {

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
            _rowHeight * 4
        ];
        _headline ctrlCommit 0;


        for "_j" from 1 to 8 do {

                private _textFadeResult = if (_j == 8) then { 0 } else { 0.5 };

                if (_i == 1) then {
                    private _picture = _display ctrlCreate ["RscPictureKeepAspect", -1];
                    _picture ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth + _columnWidth/2,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 5.5,
                        _columnWidth * 2,
                        _rowHeight * 3
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
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + str (_results_west select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 5.5,
                        _columnWidth * 4,
                        _rowHeight * 3
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };

                if (_i == 3) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + str (_results_east select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 5.5,
                        _columnWidth * 4,
                        _rowHeight * 3
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

    sleep 10;
    _display displayRemoveAllEventHandlers "KeyDown";
    _display closeDisplay 1;

};
