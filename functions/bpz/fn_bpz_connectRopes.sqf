// ripped from advanced slingloading DUDA
params ["_cargo", "_ropes", "_vehicle"];
_attachmentPoints = [_cargo] call gradTnT_fnc_bpz_getCornerPoints;
_ropeLength = (ropeLength (_ropes select 0));
_objDistance = (_cargo distance _vehicle) + 2;
if( _objDistance > _ropeLength ) then {
    hint "The cargo ropes are too short. Move vehicle closer.";
} else {
    // [_vehicle,_player] call ASL_Drop_Ropes;
    [_cargo, _attachmentPoints select 0, [0,0,-1]] ropeAttachTo (_ropes select 0);
    [_cargo, _attachmentPoints select 1, [0,0,-1]] ropeAttachTo (_ropes select 1);
    [_cargo, _attachmentPoints select 2, [0,0,-1]] ropeAttachTo (_ropes select 2);
    [_cargo, _attachmentPoints select 3, [0,0,-1]] ropeAttachTo (_ropes select 3);
};
