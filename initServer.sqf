["gradTnT_vehicleRespawn", {
	params ["_veh"];

	[_veh] spawn gradTnT_fnc_initVehicle;
    
	[_veh] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
}] call CBA_fnc_addEventHandler;


["Initialize", [true]] call BIS_fnc_dynamicGroups;
[] call grad_groupsettings_fnc_setGroupSettings;


// read parameters
TIME_OF_DAY = ["TIME_OF_DAY", 10] call BIS_fnc_getParamValue;
publicVariable "TIME_OF_DAY";

WEATHER_OVERCAST = ["WEATHER_OVERCAST", -1] call BIS_fnc_getParamValue;
publicVariable "WEATHER_OVERCAST";

WEATHER_FOG = ["WEATHER_FOG", -1] call BIS_fnc_getParamValue;
publicVariable "WEATHER_FOG";

GRAD_REPLAY_PRECISION = ["GRAD_REPLAY_PRECISION", 4] call BIS_fnc_getParamValue;
publicVariable "GRAD_REPLAY_PRECISION"; // clients need to know this

PREPARATION_TIME = ["PREPARATION_TIME", 0] call BIS_fnc_getParamValue;
publicVariable "PREPARATION_TIME";

LENGTH_OF_BATTLE = ["LENGTH_OF_BATTLE", 0] call BIS_fnc_getParamValue;
publicVariable "LENGTH_OF_BATTLE";

[LENGTH_OF_BATTLE] call BIS_fnc_countDown;

// execute weather/time settings
gradTnT_fnc_setCustomWeather = {

  // get random shit
  if (str WEATHER_OVERCAST isEqualTo "-1") then {
    WEATHER_OVERCAST = [[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0
    ], [
    0.3,
    0.3,
    0.1,
    0.1,
    0.05,
    0.025,
    0.025,
    0.025,
    0.025,
    0.025,
    0.025]] call BIS_fnc_selectRandomWeighted;
  };

  if (str WEATHER_FOG isEqualTo "-1") then {
    WEATHER_FOG = [[
    0.0,
    0.05,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    1.0
    ], [
    0.5,
    0.3,
    0.1,
    0.075,
    0.01,
    0.005,
    0.005,
    0.004,
    0.003,
    0.002,
    0.001]] call BIS_fnc_selectRandomWeighted;
  };

  // basics
  10 setOvercast WEATHER_OVERCAST;
  10 setFog WEATHER_FOG;
  10 setWindForce 0.1;

  // add specials dependent on values
  if (WEATHER_OVERCAST > 0.5 && WEATHER_OVERCAST < 0.8) then {
    10 setRain 0.5;
    10 setRainbow 0.8;
  };

  if (WEATHER_OVERCAST >= 0.8) then {
    10 setRain 1;
    10 setLightnings 0.8;
  };

  // enforce changes
  forceWeatherChange;
};


// allow view distance to be up to 10k

// set to full moon date
setDate [2015, 2, 1, TIME_OF_DAY, 1]; // set to 5:00 for perfect full moon

call gradTnT_fnc_setCustomWeather;

[PREPARATION_TIME] call gradTnT_fnc_startPreparationTime;