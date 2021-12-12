// Initialize Loading of Streamator
if !(isNil "CLib_fnc_loadModules") then { call CLib_fnc_loadModules; };

disableRemoteSensors true; // disable ai combat ability