/*

  adds actions to bridge builders and

*/

SB_BRIDGES_MAX = 2; // maximum an engineer can build before he has to destroy them again
SB_BRIDGES_VEHICLE_WEST = "gm_ge_army_marder1a2";
SB_BRIDGES_VEHICLE_EAST = "gm_gc_army_bmp1sp2"; // empty string to allow placement everywhere, else its only allowed near one of the listed vehicles
SB_BRIDGES_VEHICLE_DISTANCE = 30; // maximum distance vehicle is allowed to be

[{
    {
        private _unit = _x;

        if (_unit getVariable ["ACE_IsEngineer", 0] > 0) then {
            [] remoteExecCall ["gradTnT_fnc_bridgeActionBuild", _unit, true];
        };
    } forEach (playableUnits + switchableUnits);
}, [], 3]  call CBA_fnc_waitAndExecute;