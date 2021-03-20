params ["_hook"];

private _dummyHookPoint = "ace_fastroping_helper" createVehicle [0,0,0];
_dummyHookPoint attachTo [_hook, [0,0,0]];

// create ropes that get attached to wreck in the end
for "_i" from 0 to 3 do
{
    private _dummyRopeEnd = "ace_fastroping_helper" createVehicle [0,0,0];
    _dummyRopeEnd setPos (getPos _dummyHookPoint);
    _dummyRopeEnd hideObjectGlobal true;
    private _ropesHook = ropeCreate [_dummyHookPoint, [0,0,0], _dummyRopeEnd, [0,0,0], 3, [], ["RopeEnd", [0,0,-1]]];
};