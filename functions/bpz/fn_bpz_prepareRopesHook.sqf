params ["_hook", "_vehicle"];

private _dummyHookPoint = "ace_fastroping_helper" createVehicle [0,0,0];
_dummyHookPoint attachTo [_hook, [0,0,-0.5]];

private _ropesHook = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];

// create ropes that get attached to wreck in the end
for "_i" from 0 to 3 do
{
    private _dummyRopeEnd = "ace_fastroping_helper" createVehicle [0,0,0];
    _dummyRopeEnd setPos (getPos _dummyHookPoint);
    _dummyRopeEnd hideObjectGlobal true;
    private _rope = ropeCreate [_dummyHookPoint, [0,0,0], 5];

    _ropesHook pushBackUnique [_rope, _dummyCrane, _hook];
};

_vehicle setVariable ["gradTnT_bpz_ropesHook", _ropesHook, true];
_hook setVariable ["canHook", true, true];