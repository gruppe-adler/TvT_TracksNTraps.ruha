#include "..\component.hpp"

#define SZW(var1)           (pixelW * pixelGrid * var1)
#define SZH(var1)           (pixelH * pixelGrid * var1)
#define COLUMNW             SZW(40)
#define TOPBARH             SZH(2.5)
#define TOPBARSPACE         SZH(0.3)
#define PADDINGH            SZH(2)
#define PADDINGW            SZW(2)
#define SUMH                SZH(3)
#define COLUMNH             SZH(70)
#define TOTALH              (TOPBARH + TOPBARSPACE + 3 * PADDINGH + SUMH + COLUMNH)
#define BACKGROUNDH         (TOTALH - TOPBARH - TOPBARSPACE)
#define BACKGROUNDY         ((0.5-TOTALH/2) + TOPBARH + TOPBARSPACE)
#define DIVIDERCOLOR        [0.3,0.3,0.3,1]
#define DIVIDERWIDTH        0.4


if (!isServer && !isRemoteExecuted) exitWith {[] remoteExec ["grad_points_fnc_displayPoints",2,false]};

if (isServer && count _this == 0) exitWith {
    [
        [([WEST] call grad_points_fnc_getPointsCategorized),[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy,
        [([EAST] call grad_points_fnc_getPointsCategorized),[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy,
        [([INDEPENDENT] call grad_points_fnc_getPointsCategorized),[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy,
        [([CIVILIAN] call grad_points_fnc_getPointsCategorized),[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy
    ] remoteExec ["grad_points_fnc_displayPoints",0,false];
};

if (hasInterface && count _this > 0) then {
    "grad_common_displayPoints" cutRsc ["RscTitleDisplayEmpty","PLAIN",0,false];

    [{!isNull (uiNamespace getVariable ["RscTitleDisplayEmpty",displayNull])}, {
        params ["_pointsWest","_pointsEast","_pointsIndependent","_pointsCivilian"];

        _display = uiNamespace getVariable ["RscTitleDisplayEmpty",displayNull];

        _backgroundW = PADDINGW + (COLUMNW + PADDINGW) * (({count _x > 0} count [_pointsWest,_pointsEast,_pointsIndependent,_pointsCivilian]) max 1);

        _topbar = _display ctrlCreate ["RscText",-1];
        _topbar ctrlSetPosition [0.5-_backgroundW/2,0.5-TOTALH/2,_backgroundW,TOPBARH];
        _topbar ctrlSetBackgroundColor [(profilenamespace getvariable ['GUI_BCG_RGB_R',0]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0]),1];
        _topbar ctrlSetText "POINTS THIS GAME";
        _topbar ctrlCommit 0;

        _background = _display ctrlCreate ["RscBackground",-1];
        _background ctrlSetPosition [0.5-_backgroundW/2,BACKGROUNDY,_backgroundW,BACKGROUNDH];
        _background ctrlSetBackgroundColor [0,0,0,0.7];
        _background ctrlCommit 0;

        /*_horizontalDivider = _display ctrlCreate ["RscBackground",-1];
        _horizontalDivider ctrlSetPosition [0.5-_backgroundW/2,BACKGROUNDY + SZH(7),_backgroundW,SZH(DIVIDERWIDTH)];
        _horizontalDivider ctrlSetBackgroundColor DIVIDERCOLOR;
        _horizontalDivider ctrlCommit 0;*/

        _columnCount = 0;
        {
            if (count _x > 0) then {
                _textCtrl = _display ctrlCreate ["RscStructuredText",-1];
                _textCtrl ctrlSetPosition [(0.5-_backgroundW/2) + PADDINGW + _columnCount * (PADDINGW + COLUMNW),BACKGROUNDY + PADDINGH,COLUMNW,COLUMNH];
                _textCtrl ctrlCommit 0;

                _side = [WEST,EAST,INDEPENDENT,CIVILIAN] select _forEachIndex;
                _text = [parseText format ["<t size='1.5'>Points for <t color='%1'>%2</t>:</t>",[_side,"HTML"] call grad_common_fnc_getSideColor,[_side] call grad_common_fnc_getSideDisplayName],lineBreak,lineBreak];
                {
                    _x params ["_category","_points"];
                    _text pushBack (parseText format ["%1: <t color='%2'>%3</t>",_category,if (_points > 0) then {"#00ff00"} else {"#ff0000"},round _points]);
                    _text pushBack lineBreak;
                    false
                } count _x;
                _textCtrl ctrlSetStructuredText composeText _text;

                _sumCtrl = _display ctrlCreate ["RscStructuredText",-1];
                _sumCtrl ctrlSetPosition [(0.5-_backgroundW/2) + PADDINGW + _columnCount * (PADDINGW + COLUMNW),BACKGROUNDY + PADDINGH + COLUMNH,COLUMNW,SUMH];
                _sumCtrl ctrlSetStructuredText (parseText format ["Total: <t color = '#00ff00'>%1</t>",round ([_side] call grad_points_fnc_getPoints)]);
                _sumCtrl ctrlCommit 0;

                if (_columnCount > 0) then {
                    _horizontalDivider = _display ctrlCreate ["RscBackground",-1];
                    _horizontalDivider ctrlSetPosition [0.5-_backgroundW/2 + (PADDINGW + COLUMNW) * _columnCount,BACKGROUNDY,SZW(DIVIDERWIDTH),BACKGROUNDH];
                    _horizontalDivider ctrlSetBackgroundColor DIVIDERCOLOR;
                    _horizontalDivider ctrlCommit 0;
                };

                _columnCount = _columnCount + 1;
            };
        } forEach _this;

        [{"grad_common_displayPoints" cutRsc ["RscTitleDisplayEmpty","PLAIN",0,false];}, [], 15] call CBA_fnc_waitAndExecute;

    }, _this] call CBA_fnc_waitUntilAndExecute;
};
