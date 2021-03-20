/*


    attaches 6 helper objects to bpz crane
    attaches 6 ropes to helper objects
    attaches bpz hook to 1 rope and 5 "dummy ropes" for visual fidelity but no physx (to be debugged?)
    attaches 4 free hanging ropes to hook

*/

params ["_vehicle"];

private _hook = "gm_bpz2a1_hook" createVehicle [0,0,0];
_hook setObjectTextureGlobal [5, "\gm\gm_vehicles\gm_land\gm_tracked\gm_bpz2\gm_ge_army_bpz2\data\oli\gm_ge_army_bpz2a0_ext_01_oli_co.paa"];
private _position = (_vehicle modelToWorld (_vehicle selectionPosition "crane_hook"));
_hook setPos _position;
_hook enableRopeAttach true;

{
    private _dummyCrane = "ace_fastroping_helper" createVehicle [0,0,0];
    _dummyCrane attachTo [cursorObject, [0,0,0], _x];
    _dummyCrane enableRopeAttach true;
    _dummyCrane hideObjectGlobal true;

    private _offset = [
        [-0.1,-0.1,0],
        [-0.1,0.1,0],
        [-0.1,-0.1,0],
        [0.1,0.1,0],
        [0.1,-0.1,0],
        [0.1,0.1,0]
    ] select _forEachIndex;

    if (_forEachIndex != 4) then {
        private _dummyHook = "ace_fastroping_helper" createVehicle [0,0,0];
        _dummyHook attachTo [_hook, _offset];
        _dummyHook enableRopeAttach true;
        _dummyHook hideObjectGlobal true;


        private _rope = ropeCreate [_dummyCrane, [0,0,0], _dummyHook, [0,0,0], 2];

        private _ropesCrane = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];
        _ropesCrane pushBackUnique [_rope, _dummyCrane, _dummyHook];
        _vehicle setVariable ["gradTnT_bpz_ropesCrane", _ropesCrane, true];
    } else {
        private _rope = ropeCreate [_dummyCrane, [0,0,0], _hook, [0.1,-0.1,0], 2];

        private _ropesCrane = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];
        _ropesCrane pushBackUnique [_rope, _dummyCrane, _hook];
        _vehicle setVariable ["gradTnT_bpz_ropesCrane", _ropesCrane, true];
    };

} forEach [
  "rope_1_1_pos",
  "rope_1_2_pos",
  "rope_2_1_pos",
  "rope_2_2_pos",
  "rope_3_1_pos",
  "rope_3_2_pos"
];

[{
    params ["_hook"];

    [_hook] call gradTnT_fnc_bpz_prepareRopesHook;
}, [_hook], 1] call CBA_fnc_waitAndExecute;