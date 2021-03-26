class TIME_OF_DAY
{
    title = "Time of Day";
    values[] = {0,1,2,3,4,5,6,6.5,7,8,9,10,11,12,13,14,15,16,16.5,17,17.5,18,19,20,21,22,23};
    texts[] = {"00:00","01:00","02:00","03:00","04:00","05:00 - Full Moon","06:00","06:30 - Dawn","07:00 - Sunrise","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","16:30 - Sunset will arrive","17:00 - Sunset","17:30 - Dusk","18:00 - really dark already","19:00","20:00","21:00","22:00","23:00 - Moon Rise"};
    default = 7;
};

class LENGTH_OF_BATTLE
{
    title = "Length of Battle";
    values[] = {60,300,1800,2700,3600,5400,7200};
    texts[] = {"60s (debug)", "5min (debug)", "30min", "45min", "60min", "90min", "120min"};
    default = 300;
};

class WEATHER_OVERCAST
{
    title = "Overcast Settings";
    values[] = {0, 0.4, 0.5, 1, -1};
    texts[] = {"SUNNY", "CLOUDY", "SLIGHT RAIN", "HEAVY RAIN", "RANDOM"};
    default = 0.4;
};

class WEATHER_FOG
{
    title = "Fog Settings";
    values[] = {0, 0.05, 0.1, 0.2, 0.5, 1, -1};
    texts[] = {"None", "0.05", "0.1", "0.2", "0.5", "maximum perversum", "random"};
    default = 0.1;
};

class PREPARATION_TIME {
    title = "Preparation time";
    values[] = {0,10,120,180,240,300,480,600,900};
    texts[] = {"off","10s","2min","3min","4min","5min","8min","10min","15min"};
    default = 10;
};

class GRAD_REPLAY_PRECISION
{
    title = "InGame Replay Precision";
    values[] = {1,2,3,4,5};
    texts[] = {"every 1s","every 2s","every 3s","every 4s","every 5s"};
    default = 5;
};