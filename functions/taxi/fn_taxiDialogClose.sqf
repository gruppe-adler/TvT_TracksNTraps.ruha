private ["_map", "_btn_cancel", "_btn_choose", "_btn_exitMenu"];

disableSerialization;

_map = (uiNamespace getVariable ['gradTnT_taxiDialog_map', controlNull]);
_map ctrlShow false;

_btn_cancel = (uiNamespace getVariable ['gradTnT_taxiDialog_btn_cancel', controlNull]); 
_btn_cancel ctrlShow false;
 
_btn_choose = (uiNamespace getVariable ['gradTnT_taxiDialog_btn_choose', controlNull]);
_btn_choose ctrlShow true;
_btn_choose ctrlEnable true;

_btn_exitMenu = (uiNamespace getVariable ['gradTnT_taxiDialog_btn_exitMenu', controlNull]);
_btn_exitMenu ctrlShow true; 
_btn_exitMenu ctrlEnable true;

closeDialog 0;
openMap [false,false];

// diag_log 'closing dialog';