params ["_unit"];

private _dummyFlag = "Flag_Red_F" createVehicle [-1000,-1000,0];
_dummyFlag setFlagTexture ([_unit] call gradSB_fnc_flagGetTexture);
[_dummyFlag, 0, true] call BIS_fnc_animateFlag;
_dummyFlag setFlagOwner _unit;
_unit setVariable ["gradSB_ownerOfFlag", _dummyFlag, true];

[{
    params ["_dummyFlag", "_unit"];
    _unit getVariable ["gradSB_flagRaising", false]
},
{
    params ["_dummyFlag", "_unit"];
    _dummyFlag setFlagOwner objNull;
    deleteVehicle _dummyFlag;
    _unit setVariable ["gradSB_ownerOfFlag", objNull, true];
},[_dummyFlag, _unit]] call CBA_fnc_waitUntilAndExecute;