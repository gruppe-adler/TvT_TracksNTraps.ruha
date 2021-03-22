// ripped from Advanced Slingloading DUDA
params ["_nearByRopes", "_player"];
_nearByRopes params ["_ropes", "_hook", "_vehicle"];

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
	_player setVariable ["gradTnT_ropes", _ropes, true];
	_player setVariable ["gradTnT_ropesPickedUp", true, true];
	_hook setVariable ["canHook", false, true];

	[{
		params ["_args", "_handle"];
		_args params ["_ropes", "_vehicle"];

		 private _distanceNecessary = player distance (_vehicle modelToWorld (_vehicle selectionPosition "rope_1_1_pos")); // pickup ropes are 5m
		 [_vehicle, false, true, _distanceNecessary] call gradTnT_fnc_bzp_ropeUnwind;

	}, 0.5, [_ropes, _vehicle]] call CBA_fnc_addPerFrameHandler;
} else {
	[_args, _player] remoteExec ["gradTnT_fnc_bpz_pickUpRopes", _vehicle];
};