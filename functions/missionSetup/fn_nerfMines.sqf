/*

    nerfs mines to immobilization only

*/

// cause for vehicle damage not working

/*

["LandVehicle", "HandleDamage", {
  params ["_vehicle", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

  if (_projectile in ["ATMine_Range_Ammo", "APERSMine_Range_Ammo", "APERSBoundingMine_Range_Ammo", "SLAMDirectionalMine_Wire_Ammo", "APERSTripMine_Wire_Ammo"]) exitWith {
      private _wheels = [_vehicle] call ace_repair_fnc_getWheelHitPointsWithSelections;

      {
              _vehicle setHit [_x, 0.7 + selectRandom [0.1, 0.2, 0.3], false]; // dont always destroy completely
      } forEach _wheelHitPoints;

      {0}
  };

  _damage
}, true, [], true] call CBA_fnc_addClassEventHandler;

*/