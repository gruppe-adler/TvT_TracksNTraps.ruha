// ripped from Advanced Slingloading DUDA
params ["_args", "_player"];
_args params ["_ropes", "_hook", "_vehicle"];

if(local _vehicle) then {	
	private _helper = "Land_Can_V2_F" createVehicle position _player;
	{
		_x params ["_rope"];
		[_helper, [0, 0, 0], [0,0,-1]] ropeAttachTo _rope;
		_helper attachTo [_player, [-0.1, 0.1, 0.15], "Pelvis"];
	} forEach _ropes;
	_helper hideObjectGlobal true;

	_player setVariable ["gradTnT_ropesVehicle", _vehicle, true];
	_player setVariable ["gradTnT_ropesHelper", _helper,true];
	_hook setVariable ["canHook", false, true];
} else {
	[_args, _player] remoteExec ["gradTnT_fnc_bpz_pickUpRopes", _vehicle];
};
