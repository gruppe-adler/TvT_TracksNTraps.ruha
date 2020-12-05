private _isEngineer =  typeOf player isEqualTypeAny ["B_engineer_F", "O_engineer_F"];
private _isTankCrew = typeOf player isEqualTypeAny ["B_crew_F", "O_crew_F"];
private _isPilot = typeOf player isEqualTypeAny ["B_Helipilot_F", "O_helipilot_F"];
private _isRecon = typeOf player isEqualTypeAny ["B_recon_F", "O_recon_F"];

if (_isEngineer) then {
    ["Open Help", ["gradTnT_Engineer", "BuildingAbilities"]] call gradTnT_fnc_fieldManualAddAction;
};