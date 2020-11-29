params ["_flag"];

(_flag getVariable ["gradSB_flagOwner", sideUnknown] != side player) &&
!(_flag getVariable ["gradSB_flagAnimation", false]) &&
!isNull (player getVariable ["gradSB_ownerOfFlag", objNull])