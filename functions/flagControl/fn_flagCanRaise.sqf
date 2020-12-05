params ["_flag"];

(_flag getVariable ["gradTnT_flagOwner", sideUnknown] != side player) &&
!(_flag getVariable ["gradTnT_flagAnimation", false]) &&
!isNull (player getVariable ["gradTnT_ownerOfFlag", objNull])