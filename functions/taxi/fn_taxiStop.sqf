
private _btn_stop = (uiNamespace getVariable ['gradTnT_taxiDialog_btn_stop', controlNull]);

// use text as status indicator
if (ctrlText _btn_stop == "Stop") then {
    _btn_stop ctrlSetText "Go";

    private _driver =  driver vehicle player;
    doStop _driver;

    vehicle player vehicleChat format ['Willste aussteigen?!'];
    vehicle player lockCargo [vehicle player getCargoIndex player, false];
} else {
    _btn_stop ctrlSetText "Stop";

    private _driver =  driver vehicle player;
    [_driver] doFollow _driver;

    vehicle player vehicleChat format ['Fahre weiter.'];
    vehicle player lockCargo [vehicle player getCargoIndex player, true];
};