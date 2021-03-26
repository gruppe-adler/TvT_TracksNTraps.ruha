addMissionEventHandler
[   "Map",
    {   params ["_isOpened","_isForced"];
        // do what you want
    }
];

private _display = findDisplay 12 createDisplay "RscDisplayEmpty";  
  
private _ctrlHeadline = _display ctrlCreate ["RscStructuredText", -1];  
_ctrlHeadline ctrlSetPosition [0, safeZoneY + 0.06, 1, 0.1];  
_ctrlHeadline ctrlsetstructuredText parseText "<t align='center'>TRACKS N TRAPS</t>"; 
_ctrlHeadline ctrlSetFont "RobotoCondensedBold";  
_ctrlHeadline ctrlSetFontHeight 0.3;   
_ctrlHeadline ctrlSetTextColor [1,1,1,0.5]; 
_ctrlHeadline ctrlSetBackgroundColor [0,0,0,.6];  
_ctrlHeadline ctrlCommit 0; 
 
private _objHeldByLabel = _display ctrlCreate ["RscStructuredText", -1];  
_objHeldByLabel ctrlSetPosition [0.01, safeZoneY + 0.06 + 0.02, 1, 0.1];  
_objHeldByLabel ctrlsetstructuredText parseText "<t align='left' size='0.7' shadow='0'>OJBECTIVE HELD BY</t>"; 
_objHeldByLabel ctrlSetFont "RobotoCondensedBold"; 
_objHeldByLabel ctrlSetTextColor [1,1,1,0.5]; 
_objHeldByLabel ctrlSetBackgroundColor [0,0,0,0];  
_objHeldByLabel ctrlCommit 0; 
 
private _objHeldByValue = _display ctrlCreate ["RscStructuredText", -1];  
_objHeldByValue ctrlSetPosition [0.01, safeZoneY + 0.06 + 0.04, 1, 0.1];  
_objHeldByValue ctrlsetstructuredText parseText "<t align='left' shadow='0'>NO ONE</t>"; 
_objHeldByValue ctrlSetFont "RobotoCondensedBold";  
_objHeldByValue ctrlSetFontHeight 0.6;   
_objHeldByValue ctrlSetTextColor [1,1,1,1]; 
_objHeldByValue ctrlSetBackgroundColor [0,0,0,0];  
_objHeldByValue ctrlCommit 0;


private _battleTimeLabel = _display ctrlCreate ["RscStructuredText", -1];  
_battleTimeLabel ctrlSetPosition [1, safeZoneY + 0.06 + 0.02, 1, 0.1];  
_battleTimeLabel ctrlsetstructuredText parseText "<t align='right' size='0.7' shadow='0'>OJBECTIVE HELD BY</t>"; 
_battleTimeLabel ctrlSetFont "RobotoCondensedBold"; 
_battleTimeLabel ctrlSetTextColor [1,1,1,0.5]; 
_battleTimeLabel ctrlSetBackgroundColor [0,0,0,0];  
_battleTimeLabel ctrlCommit 0; 
 
private _battleTimeValue = _display ctrlCreate ["RscStructuredText", -1];  
_battleTimeValue ctrlSetPosition [1, safeZoneY + 0.06 + 0.04, 1, 0.1];  
_battleTimeValue ctrlsetstructuredText parseText "<t align='right' shadow='0'>NO ONE</t>"; 
_battleTimeValue ctrlSetFont "RobotoCondensedBold";  
_battleTimeValue ctrlSetFontHeight 0.6;   
_battleTimeValue ctrlSetTextColor [1,1,1,1]; 
_battleTimeValue ctrlSetBackgroundColor [0,0,0,0];  
_battleTimeValue ctrlCommit 0;