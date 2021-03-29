private _display = findDisplay 12;  
      
private _flag = missionNamespace getVariable ["gradTnT_flagObjective", objNull];      
private _sideHeldByValue = _flag getVariable ["gradTnT_flagOwner", sideUnknown];
private _objHeldByValue = "";
switch (_sideHeldByValue) do { 
      case west : {  _objHeldByValue = "<t align='left' shadow='0'>Germany</t>"; }; 
      case east : {  _objHeldByValue = "<t align='left' shadow='0'>Soviets</t>"; }; 
      case sideUnknown : {  _objHeldByValue = "<t align='left' shadow='0'>No one</t>"; }; 
      default {}; 
};


private _timeOfBattle = call BIS_fnc_missionTimeLeft;
private _timeOfBattleString = [_timeOfBattle, "HH:MM:SS"] call BIS_fnc_secondsToString;
private _timeOfBattleValue = "<t align='right' shadow='0'>" + _timeOfBattleString + "</t>";

private _ctrlHeadline = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlHeadline ctrlSetPosition [0, safeZoneY + 0.06, 1, 0.1];  
_ctrlHeadline ctrlsetstructuredText parseText "<t align='center'>TRACKS N TRAPS</t>"; 
_ctrlHeadline ctrlSetFont "RobotoCondensedBold";  
_ctrlHeadline ctrlSetFontHeight 0.03;   
_ctrlHeadline ctrlSetTextColor [1,1,1,0.5]; 
_ctrlHeadline ctrlSetBackgroundColor [0,0,0,.6];  
_ctrlHeadline ctrlCommit 0; 
 
private _ctrlObjHeldByLabel = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlObjHeldByLabel ctrlSetPosition [0.01, safeZoneY + 0.06 + 0.02, 1, 0.1];  
_ctrlObjHeldByLabel ctrlsetstructuredText parseText "<t align='left' shadow='0'>OJBECTIVE HELD BY</t>"; 
_ctrlObjHeldByLabel ctrlSetFont "RobotoCondensedBold"; 
_ctrlObjHeldByLabel ctrlSetFontHeight 0.03;
_ctrlObjHeldByLabel ctrlSetTextColor [1,1,1,0.5]; 
_ctrlObjHeldByLabel ctrlSetBackgroundColor [0,0,0,0];  
_ctrlObjHeldByLabel ctrlCommit 0; 
 
private _ctrlObjHeldByValue = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlObjHeldByValue ctrlSetPosition [0.01, safeZoneY + 0.06 + 0.04, 1, 0.1];  
_ctrlObjHeldByValue ctrlsetstructuredText parseText _objHeldByValue; 
_ctrlObjHeldByValue ctrlSetFont "RobotoCondensedBold";  
_ctrlObjHeldByValue ctrlSetFontHeight 0.06;   
_ctrlObjHeldByValue ctrlSetTextColor [1,1,1,1]; 
_ctrlObjHeldByValue ctrlSetBackgroundColor [0,0,0,0];  
_ctrlObjHeldByValue ctrlCommit 0;

private _ctrlBattleTimeLabel = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlBattleTimeLabel ctrlSetPosition [0.7, safeZoneY + 0.06 + 0.02, 0.3, 0.1];  
_ctrlBattleTimeLabel ctrlsetstructuredText parseText "<t align='right' shadow='0'>Time of Battle</t>"; 
_ctrlBattleTimeLabel ctrlSetFont "RobotoCondensedBold";
_ctrlBattleTimeLabel ctrlSetFontHeight 0.03;
_ctrlBattleTimeLabel ctrlSetTextColor [1,1,1,0.5]; 
_ctrlBattleTimeLabel ctrlSetBackgroundColor [0,0,0,0];  
_ctrlBattleTimeLabel ctrlCommit 0; 
 
private _ctrlBattleTimeValue = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlBattleTimeValue ctrlSetPosition [0.7, safeZoneY + 0.06 + 0.04, 0.3, 0.1];  
_ctrlBattleTimeValue ctrlsetstructuredText parseText _timeOfBattleValue; 
_ctrlBattleTimeValue ctrlSetFont "RobotoCondensedBold";  
_ctrlBattleTimeValue ctrlSetFontHeight 0.06;   
_ctrlBattleTimeValue ctrlSetTextColor [1,1,1,1]; 
_ctrlBattleTimeValue ctrlSetBackgroundColor [0,0,0,0];  
_ctrlBattleTimeValue ctrlCommit 0;


[{
      params ["_args", "_handle"];
      _args params ["_ctrlHeadline", "_ctrlObjHeldByLabel", "_ctrlObjHeldByValue", "_ctrlBattleTimeLabel", "_ctrlBattleTimeValue"];

      if (!visibleMap) exitWith { 
            [_handle] call CBA_fnc_removePerFrameHandler;

            {
                  ctrlDelete _x;
            } forEach [_ctrlHeadline, _ctrlObjHeldByLabel, _ctrlObjHeldByValue, _ctrlBattleTimeLabel, _ctrlBattleTimeValue];
      };

      private _timeOfBattle = call BIS_fnc_missionTimeLeft;
      private _timeOfBattleString = [_timeOfBattle, "HH:MM:SS"] call BIS_fnc_secondsToString;
      private _timeOfBattleValue = "<t align='right' shadow='0'>" + _timeOfBattleString + "</t>";
      _ctrlBattleTimeValue ctrlsetstructuredText parseText _timeOfBattleValue;
      _ctrlBattleTimeValue ctrlCommit 0;
      
}, 0, [_ctrlHeadline, _ctrlObjHeldByLabel, _ctrlObjHeldByValue, _ctrlBattleTimeLabel, _ctrlBattleTimeValue]] call CBA_fnc_addPerFrameHandler;
