params ["_vehicle"];

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

private _ctrlHeadline = _display ctrlCreate ["RscStructuredText", -1];
_ctrlHeadline ctrlSetPosition [0, 0, 1, 0.1];
_ctrlHeadline ctrlsetText "CHOOSE FORMATION SIGN";
_ctrlHeadline ctrlSetFont "RobotoCondensedBold";
_ctrlHeadline ctrlSetFontHeight 0.3; 
_ctrlHeadline ctrlSetBackgroundColor [0,0,0,.6];
_ctrlHeadline ctrlCommit 0;

private _ctrlButton = _display ctrlCreate ["RscButton", -1];
_ctrlButton ctrlSetPosition [0, 0.85, 1, 0.1];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "SUBMIT";

private _treeMultiPrefix = _display ctrlCreate ["RscTreeMulti", 1337];
_treeMultiPrefix ctrlSetPosition [0,0.1,.5,.75];
_treeMultiPrefix ctrlSetBackgroundColor [0,0,0,1];
_treeMultiPrefix ctrlSetFont "RobotoCondensedBold";
_treeMultiPrefix ctrlSetFontHeight 0.1;
_treeMultiPrefix ctrlCommit 0;

private _treeMultiSuffix = _display ctrlCreate ["RscTree", 1337];
_treeMultiSuffix ctrlSetPosition [0.5,0.1,.5,.75];
_treeMultiSuffix ctrlSetBackgroundColor [0,0,0,1];
_treeMultiSuffix ctrlSetFont "RobotoCondensedBold";
_treeMultiSuffix ctrlSetFontHeight 0.1; 
_treeMultiSuffix ctrlCommit 0;

_treeMultiSuffix setVariable ["_treeMultiPrefix", _treeMultiPrefix];
_treeMultiPrefix setVariable ["_treeMultiSuffix", _treeMultiSuffix];

_treeMultiPrefix tvAdd [[], "A"];
_treeMultiPrefix tvAdd [[], "B"];
_treeMultiPrefix tvAdd [[], "C"];
_treeMultiPrefix tvAdd [[], "D"];
_treeMultiPrefix tvAdd [[], "E"];
_treeMultiPrefix tvAdd [[], "F"];

_treeMultiSuffix tvAdd [[], "-"];
_treeMultiSuffix tvAdd [[], "1"];
_treeMultiSuffix tvAdd [[], "2"];
_treeMultiSuffix tvAdd [[], "3"];
_treeMultiSuffix tvAdd [[], "4"];

missionNamespace setVariable ["gradTnT_changeGroupIdCachePrefix", ""];
missionNamespace setVariable ["gradTnT_changeGroupIdCacheSuffix", ""];
missionNamespace setVariable ["gradTnT_changeGroupIdCacheVehicle", _vehicle];

_treeMultiPrefix ctrlAddEventHandler ["TreeSelChanged", {
    params ["_control", "_selectionPath"];

    private _treeMultiSuffix = _control getVariable ["_treeMultiSuffix", controlNull];

    if (_control tvText _selectionPath == "E" ||
        _control tvText _selectionPath == "F") then {

        hint "PREFIX EF from left";
        // _treeMultiSuffix tvSetCurSel [-1];
        // _treeMultiSuffix tvSetCurSel [0];
    };
    missionNamespace setVariable ["gradTnT_changeGroupIdCachePrefix", _control tvText _selectionPath];
}];

_treeMultiSuffix ctrlAddEventHandler ["TreeSelChanged", {
    params ["_control", "_selectionPath"];

    private _treeMultiPrefix = _control getVariable ["_treeMultiPrefix", controlNull];

    if (_treeMultiPrefix tvText (tvCurSel _treeMultiPrefix) == "E" ||
        _treeMultiPrefix tvText (tvCurSel _treeMultiPrefix) == "F") then {

        hint "PREFIX EF from right";
       //  _control tvSetCurSel [-1];
       // _control tvSetCurSel [0];
    };
    missionNamespace setVariable ["gradTnT_changeGroupIdCacheSuffix", _control tvText _selectionPath];
}];

_ctrlButton ctrlAddEventHandler ["ButtonClick", 
{
    params ["_ctrl"];
    private _display = ctrlParent _ctrl;
    private _prefix = missionNamespace getVariable ["gradTnT_changeGroupIdCachePrefix", ""];
    private _suffix = missionNamespace getVariable ["gradTnT_changeGroupIdCacheSuffix", ""];
    private _text = _prefix + " " + _suffix;

    if (_text == "") then { _text = "EMPTY" };
    hint _text;

    private _vehicle = missionNamespace getVariable ["gradTnT_changeGroupIdCacheVehicle", objNull];
    _vehicle setVariable ["gradTnT_bftGroupID_prefix", _prefix, true];
    _vehicle setVariable ["gradTnT_bftGroupID_suffix", _suffix, true];

    [_vehicle, (_prefix + _suffix), "1234"] call gradTnT_fnc_configureVehicleMarking;

    _display closeDisplay 1;
}];
