params ["_vehicle", ["_formationParam", "none"], ["_vehicleNumberParam", "none"]];

private _attributesExisting = _vehicle getVariable ["gm_vehicle_attributes", []];

private _supportedStrings = [
    "A0",
    "A1",
    "A2",
    "A3",
    "A4",
    "B0",
    "B1",
    "B2",
    "B3",
    "B4",
    "C0",
    "C1",
    "C2",
    "C3",
    "C4",
    "D0",
    "D1",
    "D2",
    "D3",
    "D4",
    "E",
    "F"
];

if (_formationParam in _supportedStrings) then {
    private _formationSignString = "";
    _formationSignString = "gm_insignia_formation_" + _formationParam + "_yel";
    (_attributesExisting select 3) set [5, _formationSignString];
};

if (_vehicleNumberParam != "none") then {
    (_attributesExisting select 2) set [0, _vehicleNumberParam];
};

_vehicle setVariable ["gm_vehicle_attributes", _attributesExisting];
[_vehicle] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;


/*
[
    ["gm_licenseplate_none","VA##-####"],
    ["","gm_din_norm_gry","gm_tacticalSign_none","","gm_din_norm_gry"],
    ["####","gm_gc_schablonier_gry"],
    ["gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_none"],
    ["gm_insignia_none"],
    ["gm_insignia_ur_star_01","0","gm_insignia_none"]
]


private _attributes =
[
    [
      "gm_vehicleMarkings_LicensePlates_Plate_attribute",
      "gm_vehicleMarkings_LicensePlates_Numbers_attribute"
    ],
    [
      "gm_vehicleMarkings_tacticalSign_PreIcon_attribute",
      "",
      "gm_vehicleMarkings_tacticalSign_Icon_attribute",
      "gm_vehicleMarkings_tacticalSign_PostIcon_attribute",
      ""
    ],
    [
      "gm_vehicleMarkings_tacticalNumber_Number_attribute",
      "gm_vehicleMarkings_tacticalNumber_Numberfont_attribute"
    ],
    [
      "gm_vehicleMarkings_Insignias_MissionSmall_attribute",
      "gm_vehicleMarkings_Insignias_MissionLarge_attribute",
      "gm_vehicleMarkings_Insignias_Recon_attribute",
      "gm_vehicleMarkings_Insignias_Unit_attribute",
      "gm_vehicleMarkings_Insignias_Company_attribute",
      "gm_vehicleMarkings_Insignias_Formation_attribute"
    ],
    [
      "gm_vehicleMarkings_Insignias_HazardSign_attribute"
    ],
    [
      "gm_vehicleMarkings_Insignias_nation_attribute",
      "gm_vehicleMarkings_Insignias_nationPosition_attribute",
      "gm_vehicleMarkings_Insignias_flag_attribute"
    ]
];


*/

[["gm_ge_army_blk","A"],["","gm_din_norm_gry","gm_tacticalSign_nato_armored","","gm_din_norm_gry"],["123","gm_din_norm_blk_gry"],["gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_none","gm_insignia_formation_A1_yel"],["gm_insignia_none"],["gm_insignia_ge_army_01","0","gm_insignia_none"]]