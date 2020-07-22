private _objects = nearestTerrainObjects [[worldSize/2, worldSize/2, 0], ["HIDE"], worldSize];

{
    if (typeOf _x in [
        "land_gm_wall_vehicleditch_700_win",
        "land_gm_wall_vehicleditch_700",
        "land_gm_fence_border_gz1_600"
        ]) then {
        _x hideObjectGlobal true;
        _x allowDamage false;
    };
} forEach _objects;
