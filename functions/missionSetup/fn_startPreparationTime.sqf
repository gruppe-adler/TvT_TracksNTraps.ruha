_this spawn {
    params [["_preparationTime",0]];

    while {_preparationTime > -1} do {
        [_preparationTime] remoteExec ["gradTnT_fnc_preparationTimeCountdown",0,false];
        _preparationTime = _preparationTime - 1;
        sleep 1;
    };

    MISSION_STARTED = true;
    publicVariable "MISSION_STARTED";
};
