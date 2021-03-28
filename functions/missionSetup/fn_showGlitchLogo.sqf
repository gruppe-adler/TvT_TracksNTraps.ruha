params ["_fadeIn", "_duration", ["_isLast", false]];

[{
    params ["_duration", "_isLast"];

    private _textures = if (_isLast) then { ["glitch6.paa"] } else { [
        "glitch1.paa",
        "glitch2.paa",
        "glitch3.paa",
        "glitch4.paa",
        "glitch5.paa"
    ] };

    private _texture = "UserTexture10m_F" createVehicleLocal [0,0,0];
    _texture setDir getDir player;
    private _position = (player getRelPos [600, 0]);
    _position set [2,100];
    _texture setPos _position;
    _texture setVectorUp [0,0,1];

    _texture setObjectTexture [0, "pics\glitch1.paa"];
    _texture attachTo [player];
    _texture setObjectScale 25;


    private _handle = [{
        params ["_args", "_handle"];
        _args params ["_texture", "_textures"];

        private _path = "pics\" + selectRandom _textures;
        _texture setObjectTexture [0, _path];

    }, 0.1, [_texture, _textures]] call CBA_fnc_addPerFrameHandler;


    [{
        params ["_handle", "_texture"];

        [_handle] call CBA_fnc_removePerFrameHandler;
        deleteVehicle _texture;
    }, [_handle, _texture], _duration] call CBA_fnc_waitAndExecute;

}, [_duration, _isLast], _fadeIn] call CBA_fnc_waitAndExecute;