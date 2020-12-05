/*
 * Name: gradTnT_fnc_deleteBorder
 * Author: nomisum, DerZade
 * Called by postinit and will execute only on server.
 * Deletes the border.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 */

if (!isServer) exitWith {};

private _BORDER_MODELS = [
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_vehicleditch_700.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gz1_600.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_gc_g501_sm70_03.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_gc_g501_sm70_01.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_gc_g501_sm70_02.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gz1_gate_350_r.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gz1_gate_350_w.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_gc_borderpost_01.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_ge_borderpost_02.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_gc_borderpost_05.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_gc_borderpost_02.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_gc_borderpost_04.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_ge_borderpost_03.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_concrete_02_300.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_ge_borderpost_01.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_gc_g501_power_01.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gssz_70_600.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gssz_70_gate_350_r.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_wall_gc_borderpost_03.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gssz_70_gate_350_w.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_gssz_70_600_post.p3d",
    "gm\gm_structures\gm_structures_euro_80\walls\gm_fence_border_concrete_01_300.p3d"
];

private _TOWER_MODELS = [
    "gm\gm_structures\gm_structures_euro_80\towers\gm_tower_bt_11_60.p3d",
    "gm\gm_structures\gm_structures_euro_80\towers\gm_tower_bt_6_fuest_80.p3d",
    "gm\gm_structures\gm_structures_euro_80\towers\gm_tower_bt_11_60.p3d"
];

private _pos = getPos trg_gameArea;

(triggerArea trg_gameArea) params ["_sizeX", "_sizeY", "_angle", "_isRectangle"];

private _radius = (_sizeX max _sizeY);
if (_isRectangle) then {
    _radius = sqrt (_sizeX ^ 2 + _sizeY ^ 2)
};


{
    _x params ["_types", "_allowedModels"];

    private _obj = nearestTerrainObjects [_pos, _types, _radius];
    {
        (getModelInfo _x) params ["", "_path"];

        if (_path in _allowedModels) then {
            _x hideObjectGlobal true;

            if !(local _x) then {
                [_x, false] remoteExec ["allowDamage", _x];
            } else {
                _x allowDamage false;
            };
        };
    } forEach (_obj inAreaArray trg_gameArea);
} forEach [
    [["HIDE"], _BORDER_MODELS],
    [["VIEW-TOWER"], _TOWER_MODELS]
];
