params [["_component", "bft", [""]]];

if (isNil "gradTnT_has_data_addon") then {
	gradTnT_has_data_addon = "gradtnt_data" in activatedAddons;
	diag_log format["[GRAD TNT] MAP DRAW DEBUG INFO | Has addon: %1 | Side: %2", gradTnT_has_data_addon, playerSide];
};

private _pathPrefix = [
    getMissionPath format ["functions\%1\data", _component],
    format ["\gradTnT_data\%1", _component]
] select (gradTnT_has_data_addon && playerSide isEqualTo west);

_pathPrefix