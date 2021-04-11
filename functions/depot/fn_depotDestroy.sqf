params ["_player", "_depotHelper"];


[   20, 
    [_player, _depotHelper], 
    {
        _args params ["_player", "_depotHelper"];

        private _depot = _depotHelper getVariable ["gradTnT_depotHelperDepot", objNull];
        private _depotObjects = _depot getVariable ["gradTnt_depotObjects", []];

        {
          _x setDamage [1, false];

          // make depot dark bc no destr model
          if (_forEachIndex == 0) then {
            _x setObjectTextureGlobal [0,"#(rgb,8,8,3)color(0.025,0.05,0.025,1)"];
          };
        } forEach _depotObjects;

        deleteVehicle _depotHelper;

        _depot setVariable ["gradTnT_depotDestroyed", true, true];

        // down counter
        private _side = side _player;
        private _depotsBuiltID = format ["gradTnT_depotsBuilt_%1", _side];
        private _depotsBuilt = missionNameSpace getVariable [_depotsBuiltID, 0];
        _depotsBuilt = _depotsBuilt -1;
        missionNameSpace setVariable [_depotsBuiltID, _depotsBuilt, true];

        // if destroying enemy depot, give points
        private _depotSide = [_depot] call gradTnT_fnc_side;
        if (_side != _depotSide) then {
            ["gradTnT_points", ["depot", _side]] call CBA_fnc_serverEvent;
        };

        [_depotSide, _depot, "Depot", false] remoteExec ["gradTnT_fnc_depotAddRespawn", 2];
        [west, _depot, "Depot", true] remoteExec ["gradTnT_fnc_depotAddRespawn", 2];
    }, 
    {
        hint "Destruction aborted!";
    }, 
    "Destroying Depot"
] call ace_common_fnc_progressBar;