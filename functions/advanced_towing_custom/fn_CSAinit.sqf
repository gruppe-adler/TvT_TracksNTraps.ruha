/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


/*

    additional notice: minor adjustments to original script were made by nomisum for Gruppe Adler 2021
    functions are renamed to CSA (Custom SA) to avoid conflicts/confusion
    main goal was ACE Interact compatibility and removal from mouse wheel

*/

#define CSA_Find_Surface_ASL_Under_Position(_object,_positionAGL,_returnSurfaceASL,_canFloat) \
_objectASL = AGLToASL (_object modelToWorldVisual (getCenterOfMass _object)); \
_surfaceIntersectStartASL = [_positionAGL select 0, _positionAGL select 1, (_objectASL select 2) + 1]; \
_surfaceIntersectEndASL = [_positionAGL select 0, _positionAGL select 1, (_objectASL select 2) - 5]; \
_surfaces = lineIntersectsSurfaces [_surfaceIntersectStartASL, _surfaceIntersectEndASL, _object, objNull, true, 5]; \
_returnSurfaceASL = AGLToASL _positionAGL; \
{ \
    scopeName "surfaceLoop"; \
    if( isNull (_x select 2) ) then { \
        _returnSurfaceASL = _x select 0; \
        breakOut "surfaceLoop"; \
    } else { \
        if!((_x select 2) isKindOf "RopeSegment") then { \
            _objectFileName = str (_x select 2); \
            if((_objectFileName find " t_") == -1 && (_objectFileName find " b_") == -1) then { \
                _returnSurfaceASL = _x select 0; \
                breakOut "surfaceLoop"; \
            }; \
        }; \
    }; \
} forEach _surfaces; \
if(_canFloat && (_returnSurfaceASL select 2) < 0) then { \
    _returnSurfaceASL set [2,0]; \
}; \

#define CSA_Find_Surface_ASL_Under_Model(_object,_modelOffset,_returnSurfaceASL,_canFloat) \
CSA_Find_Surface_ASL_Under_Position(_object, (_object modelToWorldVisual _modelOffset), _returnSurfaceASL,_canFloat);
            
#define CSA_Find_Surface_AGL_Under_Model(_object,_modelOffset,_returnSurfaceAGL,_canFloat) \
CSA_Find_Surface_ASL_Under_Model(_object,_modelOffset,_returnSurfaceAGL,_canFloat); \
_returnSurfaceAGL = ASLtoAGL _returnSurfaceAGL;

#define CSA_Get_Cargo(_vehicle,_cargo) \
if( count (ropeAttachedObjects _vehicle) == 0 ) then { \
    _cargo = objNull; \
} else { \
    _cargo = ((ropeAttachedObjects _vehicle) select 0) getVariable ["CSA_Cargo",objNull]; \
};
        
CSA_Advanced_Towing_Install = {

// Prevent advanced towing from installing twice
if(!isNil "CSA_TOW_INIT") exitWith {};
CSA_TOW_INIT = true;

diag_log "Custom Advanced Towing Loading...";

CSA_Simulate_Towing_Speed = {
    
    params ["_vehicle"];
    
    private ["_runSimulation","_currentCargo","_maxVehicleSpeed","_maxTowedVehicles","_vehicleMass"];
    
    _maxVehicleSpeed = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "maxSpeed");
    _vehicleMass = 1000 max (getMass _vehicle);
    _maxTowedCargo = missionNamespace getVariable ["CSA_MAX_TOWED_CARGO",2];
    _runSimulation = true;
    
    private ["_currentVehicle","_totalCargoMass","_totalCargoCount","_findNextCargo","_towRopes","_ropeLength"];
    private ["_ends","_endsDistance","_currentMaxSpeed","_newMaxSpeed"];
    
    while {_runSimulation} do {
    
        // Calculate total mass and count of cargo being towed (only takes into account
        // cargo that's actively being towed (e.g. there's no slack in the rope)
        
        _currentVehicle = _vehicle;
        _totalCargoMass = 0;
        _totalCargoCount = 0;
        _findNextCargo = true;
        while {_findNextCargo} do {
            _findNextCargo = false;
            CSA_Get_Cargo(_currentVehicle,_currentCargo);
            if(!isNull _currentCargo) then {
                _towRopes = _currentVehicle getVariable ["CSA_Tow_Ropes",[]];
                if(count _towRopes > 0) then {
                    _ropeLength = ropeLength (_towRopes select 0);
                    _ends = ropeEndPosition (_towRopes select 0);
                    _endsDistance = (_ends select 0) distance (_ends select 1);
                    if( _endsDistance >= _ropeLength - 2 ) then {
                        _totalCargoMass = _totalCargoMass + (1000 max (getMass _currentCargo));
                        _totalCargoCount = _totalCargoCount + 1;
                        _currentVehicle = _currentCargo;
                        _findNextCargo = true;
                    };
                };
            };
        };
    
        _newMaxSpeed = _maxVehicleSpeed / (1 max ((_totalCargoMass /  _vehicleMass) * 2));
        _newMaxSpeed = (_maxVehicleSpeed * 0.75) min _newMaxSpeed;
        
        // Prevent vehicle from moving if trying to move more cargo than pre-defined max
        if(_totalCargoCount > _maxTowedCargo) then {
            _newMaxSpeed = 0;
        };
        
        _currentMaxSpeed = _vehicle getVariable ["CSA_Max_Tow_Speed",_maxVehicleSpeed];
        
        if(_currentMaxSpeed != _newMaxSpeed) then {
            _vehicle setVariable ["CSA_Max_Tow_Speed",_newMaxSpeed];
        };
        
        sleep 0.1;
        
    };
};

CSA_Simulate_Towing = {

    params ["_vehicle","_vehicleHitchModelPos","_cargo","_cargoHitchModelPos","_ropeLength"];

    private ["_lastCargoHitchPosition","_lastCargoVectorDir","_cargoLength","_maxDistanceToCargo","_lastMovedCargoPosition","_cargoHitchPoints"];
    private ["_vehicleHitchPosition","_cargoHitchPosition","_newCargoHitchPosition","_cargoVector","_movedCargoVector","_attachedObjects","_currentCargo"];
    private ["_newCargoDir","_lastCargoVectorDir","_newCargoPosition","_doExit","_cargoPosition","_vehiclePosition","_maxVehicleSpeed","_vehicleMass","_cargoMass","_cargoCanFloat"];   
    private ["_cargoCorner1AGL","_cargoCorner1ASL","_cargoCorner2AGL","_cargoCorner2ASL","_cargoCorner3AGL","_cargoCorner3ASL","_cargoCorner4AGL","_cargoCorner4ASL","_surfaceNormal1","_surfaceNormal2","_surfaceNormal"];
    private ["_cargoCenterASL","_surfaceHeight","_surfaceHeight2","_maxSurfaceHeight"];
    
    _maxVehicleSpeed = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "maxSpeed");
    _cargoCanFloat = if( getNumber (configFile >> "CfgVehicles" >> typeOf _cargo >> "canFloat") == 1 ) then { true } else { false };
    
    private ["_cargoCenterOfMassAGL","_cargoModelCenterGroundPosition"];
    CSA_Find_Surface_AGL_Under_Model(_cargo,getCenterOfMass _cargo,_cargoCenterOfMassAGL,_cargoCanFloat);
    _cargoModelCenterGroundPosition = _cargo worldToModelVisual _cargoCenterOfMassAGL;
    _cargoModelCenterGroundPosition set [0,0];
    _cargoModelCenterGroundPosition set [1,0];
    _cargoModelCenterGroundPosition set [2, (_cargoModelCenterGroundPosition select 2) - 0.05]; // Adjust height so that it doesn't ride directly on ground
    
    // Calculate cargo model corner points
    private ["_cargoCornerPoints"];
    _cargoCornerPoints = [_cargo] call CSA_Get_Corner_Points;
    _corner1 = _cargoCornerPoints select 0;
    _corner2 = _cargoCornerPoints select 1;
    _corner3 = _cargoCornerPoints select 2;
    _corner4 = _cargoCornerPoints select 3;
    
    
    // Try to set cargo owner if the towing client doesn't own the cargo
    if(local _vehicle && !local _cargo) then {
        [[_cargo, clientOwner],"CSA_Set_Owner"] call CSA_RemoteExecServer;
    };
    
    _vehicleHitchModelPos set [2,0];
    _cargoHitchModelPos set [2,0];
    
    _lastCargoHitchPosition = _cargo modelToWorld _cargoHitchModelPos;
    _lastCargoVectorDir = vectorDir _cargo;
    _lastMovedCargoPosition = getPos _cargo;
    
    _cargoHitchPoints = [_cargo] call CSA_Get_Hitch_Points;
    _cargoLength = (_cargoHitchPoints select 0) distance (_cargoHitchPoints select 1);
    
    _vehicleMass = 1 max (getMass _vehicle);
    _cargoMass = getMass _cargo;
    if(_cargoMass == 0) then {
        _cargoMass = _vehicleMass;
    };
    
    _maxDistanceToCargo = _ropeLength;

    _doExit = false;
    
    // Start vehicle speed simulation
    [_vehicle] spawn CSA_Simulate_Towing_Speed;
    
    while {!_doExit} do {

        _vehicleHitchPosition = _vehicle modelToWorld _vehicleHitchModelPos;
        _vehicleHitchPosition set [2,0];
        _cargoHitchPosition = _lastCargoHitchPosition;
        _cargoHitchPosition set [2,0];
        
        _cargoPosition = getPos _cargo;
        _vehiclePosition = getPos _vehicle;
        
        if(_vehicleHitchPosition distance _cargoHitchPosition > _maxDistanceToCargo) then {
        
            // Calculated simulated towing position + direction
            _newCargoHitchPosition = _vehicleHitchPosition vectorAdd ((_vehicleHitchPosition vectorFromTo _cargoHitchPosition) vectorMultiply _ropeLength);
            _cargoVector = _lastCargoVectorDir vectorMultiply _cargoLength;
            _movedCargoVector = _newCargoHitchPosition vectorDiff _lastCargoHitchPosition;
            _newCargoDir = vectorNormalized (_cargoVector vectorAdd _movedCargoVector);
            //if(_isRearCargoHitch) then {
            //  _newCargoDir = _newCargoDir vectorMultiply -1;
            //};
            _lastCargoVectorDir = _newCargoDir;
            _newCargoPosition = _newCargoHitchPosition vectorAdd (_newCargoDir vectorMultiply -(vectorMagnitude (_cargoHitchModelPos)));
            
            CSA_Find_Surface_ASL_Under_Position(_cargo,_newCargoPosition,_newCargoPosition,_cargoCanFloat);
            
            // Calculate surface normal (up) (more realistic than surfaceNormal function)
            CSA_Find_Surface_ASL_Under_Model(_cargo,_corner1,_cargoCorner1ASL,_cargoCanFloat);
            CSA_Find_Surface_ASL_Under_Model(_cargo,_corner2,_cargoCorner2ASL,_cargoCanFloat);
            CSA_Find_Surface_ASL_Under_Model(_cargo,_corner3,_cargoCorner3ASL,_cargoCanFloat);
            CSA_Find_Surface_ASL_Under_Model(_cargo,_corner4,_cargoCorner4ASL,_cargoCanFloat);
            _surfaceNormal1 = (_cargoCorner1ASL vectorFromTo _cargoCorner3ASL) vectorCrossProduct (_cargoCorner1ASL vectorFromTo _cargoCorner2ASL);
            _surfaceNormal2 = (_cargoCorner4ASL vectorFromTo _cargoCorner2ASL) vectorCrossProduct (_cargoCorner4ASL vectorFromTo _cargoCorner3ASL);
            _surfaceNormal = _surfaceNormal1 vectorAdd _surfaceNormal2;
            
            if(missionNamespace getVariable ["CSA_TOW_DEBUG_ENABLED", false]) then {
                if(isNil "Csa_tow_debug_arrow_1") then {
                    Csa_tow_debug_arrow_1 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                    Csa_tow_debug_arrow_2 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                    Csa_tow_debug_arrow_3 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                    Csa_tow_debug_arrow_4 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                };
                Csa_tow_debug_arrow_1 setPosASL _cargoCorner1ASL;
                Csa_tow_debug_arrow_1 setVectorUp _surfaceNormal;
                Csa_tow_debug_arrow_2 setPosASL _cargoCorner2ASL;
                Csa_tow_debug_arrow_2 setVectorUp _surfaceNormal;
                Csa_tow_debug_arrow_3 setPosASL _cargoCorner3ASL;
                Csa_tow_debug_arrow_3 setVectorUp _surfaceNormal;
                Csa_tow_debug_arrow_4 setPosASL _cargoCorner4ASL;
                Csa_tow_debug_arrow_4 setVectorUp _surfaceNormal;
            };
            
            // Calculate adjusted surface height based on surface normal (prevents vehicle from clipping into ground)
            _cargoCenterASL = AGLtoASL (_cargo modelToWorldVisual [0,0,0]);
            _cargoCenterASL set [2,0];
            _surfaceHeight = ((_cargoCorner1ASL vectorAdd ( _cargoCenterASL vectorMultiply -1)) vectorDotProduct _surfaceNormal1) /  ([0,0,1] vectorDotProduct _surfaceNormal1);
            _surfaceHeight2 = ((_cargoCorner1ASL vectorAdd ( _cargoCenterASL vectorMultiply -1)) vectorDotProduct _surfaceNormal2) /  ([0,0,1] vectorDotProduct _surfaceNormal2);
            _maxSurfaceHeight = (_newCargoPosition select 2) max _surfaceHeight max _surfaceHeight2;
            _newCargoPosition set [2, _maxSurfaceHeight ];
            
            _newCargoPosition = _newCargoPosition vectorAdd ( _cargoModelCenterGroundPosition vectorMultiply -1 );
            
            _cargo setVectorDir _newCargoDir;
            _cargo setVectorUp _surfaceNormal;
            _cargo setPosWorld _newCargoPosition;
            
            _lastCargoHitchPosition = _newCargoHitchPosition;
            _maxDistanceToCargo = _vehicleHitchPosition distance _newCargoHitchPosition;
            _lastMovedCargoPosition = _cargoPosition;

            _massAdjustedMaxSpeed = _vehicle getVariable ["CSA_Max_Tow_Speed",_maxVehicleSpeed];     
            if(speed _vehicle > (_massAdjustedMaxSpeed)+0.1) then {
                _vehicle setVelocity ((vectorNormalized (velocity _vehicle)) vectorMultiply (_massAdjustedMaxSpeed/3.6));
            };
            
        } else {

            if(_lastMovedCargoPosition distance _cargoPosition > 2) then {
                _lastCargoHitchPosition = _cargo modelToWorld _cargoHitchModelPos;
                _lastCargoVectorDir = vectorDir _cargo;
            };
            
        };
        
        // If vehicle isn't local to the client, switch client running towing simulation
        if(!local _vehicle) then {
            [_this,"CSA_Simulate_Towing",_vehicle] call CSA_RemoteExec;
            _doExit = true;
        };
        
        // If the vehicle isn't towing anything, stop the towing simulation
        CSA_Get_Cargo(_vehicle,_currentCargo);
        if(isNull _currentCargo) then {
            _doExit = true;
        };
        
        sleep 0.01;
        
    };
};

CSA_Get_Corner_Points = {
    params ["_vehicle"];
    private ["_centerOfMass","_bbr","_p1","_p2","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];
    private ["_maxWidth","_widthOffset","_maxLength","_lengthOffset","_widthFactor","_lengthFactor"];
    
    // Correct width and length factor for air
    _widthFactor = 0.75;
    _lengthFactor = 0.75;
    if(_vehicle isKindOf "Air") then {
        _widthFactor = 0.3;
    };
    if(_vehicle isKindOf "Helicopter") then {
        _widthFactor = 0.2;
        _lengthFactor = 0.45;
    };
    
    _centerOfMass = getCenterOfMass _vehicle;
    _bbr = boundingBoxReal _vehicle;
    _p1 = _bbr select 0;
    _p2 = _bbr select 1;
    _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
    _widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
    _maxLength = abs ((_p2 select 1) - (_p1 select 1));
    _lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
    _rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, _centerOfMass select 2];
    _rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, _centerOfMass select 2];
    _frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, _centerOfMass select 2];
    _frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, _centerOfMass select 2];
    
    if(missionNamespace getVariable ["CSA_TOW_DEBUG_ENABLED", false]) then {
        if(isNil "Csa_tow_debug_arrow_1") then {
            Csa_tow_debug_arrow_1 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
            Csa_tow_debug_arrow_2 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
            Csa_tow_debug_arrow_3 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
            Csa_tow_debug_arrow_4 = "Sign_Arrow_F" createVehicleLocal [0,0,0];
        };
        Csa_tow_debug_arrow_1 setPosASL  AGLtoASL (_vehicle modelToWorldVisual _rearCorner);
        Csa_tow_debug_arrow_2 setPosASL  AGLtoASL (_vehicle modelToWorldVisual _rearCorner2);
        Csa_tow_debug_arrow_3 setPosASL  AGLtoASL (_vehicle modelToWorldVisual _frontCorner);
        Csa_tow_debug_arrow_4 setPosASL  AGLtoASL (_vehicle modelToWorldVisual _frontCorner2);
    };
            
    [_rearCorner,_rearCorner2,_frontCorner,_frontCorner2];
};

CSA_Get_Hitch_Points = {
    params ["_vehicle"];
    private ["_cornerPoints","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2","_rearHitchPoint"];
    private ["_frontHitchPoint","_sideLeftPoint","_sideRightPoint"];
    _cornerPoints = [_vehicle] call CSA_Get_Corner_Points;
    _rearCorner = _cornerPoints select 0;
    _rearCorner2 = _cornerPoints select 1;
    _frontCorner = _cornerPoints select 2;
    _frontCorner2 = _cornerPoints select 3;
    _rearHitchPoint = ((_rearCorner vectorDiff _rearCorner2) vectorMultiply 0.5) vectorAdd  _rearCorner2;
    _frontHitchPoint = ((_frontCorner vectorDiff _frontCorner2) vectorMultiply 0.5) vectorAdd  _frontCorner2;
    //_sideLeftPoint = ((_frontCorner vectorDiff _rearCorner) vectorMultiply 0.5) vectorAdd  _frontCorner;
    //_sideRightPoint = ((_frontCorner2 vectorDiff _rearCorner2) vectorMultiply 0.5) vectorAdd  _frontCorner2;
    [_frontHitchPoint,_rearHitchPoint];
};

CSA_Attach_Tow_Ropes = {
    params ["_cargo","_player"];
    _vehicle = _player getVariable ["CSA_Tow_Ropes_Vehicle", objNull];
    if(!isNull _vehicle) then {
        if(local _vehicle) then {
            private ["_towRopes","_vehicleHitch","_cargoHitch","_objDistance","_ropeLength"];
            _towRopes = _vehicle getVariable ["CSA_Tow_Ropes",[]];
            if(count _towRopes == 1) then {
            
                /*
                private ["_cargoHitchPoints","_distanceToFrontHitch","_distanceToRearHitch","_isRearCargoHitch"];
                _cargoHitchPoints = [_cargo] call CSA_Get_Hitch_Points;
                _distanceToFrontHitch = player distance (_cargo modelToWorld (_cargoHitchPoints select 0));
                _distanceToRearHitch = player distance (_cargo modelToWorld (_cargoHitchPoints select 1));
                if( _distanceToFrontHitch < _distanceToRearHitch ) then {
                    _cargoHitch = _cargoHitchPoints select 0;
                    _isRearCargoHitch = false;
                } else {
                    _cargoHitch = _cargoHitchPoints select 1;
                    _isRearCargoHitch = true;
                };
                */
                
                _cargoHitch = ([_cargo] call CSA_Get_Hitch_Points) select 0;
                
                _vehicleHitch = ([_vehicle] call CSA_Get_Hitch_Points) select 1;
                _ropeLength = (ropeLength (_towRopes select 0));
                _objDistance = ((_vehicle modelToWorld _vehicleHitch) distance (_cargo modelToWorld _cargoHitch));
                if( _objDistance > _ropeLength ) then {
                    [["The tow ropes are too short. Move vehicle closer.", false],"CSA_Hint",_player] call CSA_RemoteExec;
                } else {        
                    [_vehicle,_player] call CSA_Drop_Tow_Ropes;
                    _helper = "Land_Can_V2_F" createVehicle position _cargo;
                    _helper attachTo [_cargo, _cargoHitch];
                    _helper setVariable ["CSA_Cargo",_cargo,true];
                    hideObject _helper;
                    [[_helper],"CSA_Hide_Object_Global"] call CSA_RemoteExecServer;
                    [_helper, [0,0,0], [0,0,-1]] ropeAttachTo (_towRopes select 0);
                    [_vehicle,_vehicleHitch,_cargo,_cargoHitch,_ropeLength] spawn CSA_Simulate_Towing;
                };
            };
        } else {
            [_this,"CSA_Attach_Tow_Ropes",_vehicle,true] call CSA_RemoteExec;
        };
    };
};

CSA_Take_Tow_Ropes = {
    params ["_vehicle","_player"];
    if(local _vehicle) then {
        diag_log format ["Take Tow Ropes Called %1", _this];
        private ["_existingTowRopes","_hitchPoint","_rope"];
        _existingTowRopes = _vehicle getVariable ["CSA_Tow_Ropes",[]];
        if(count _existingTowRopes == 0) then {
            _hitchPoint = [_vehicle] call CSA_Get_Hitch_Points select 1;
            _rope = ropeCreate [_vehicle, _hitchPoint, 10];
            _vehicle setVariable ["CSA_Tow_Ropes",[_rope],true];
            _this call CSA_Pickup_Tow_Ropes;
        };
    } else {
        [_this,"CSA_Take_Tow_Ropes",_vehicle,true] call CSA_RemoteExec;
    };
};

CSA_Pickup_Tow_Ropes = {
    params ["_vehicle","_player"];
    if(local _vehicle) then {
        private ["_attachedObj","_helper"];
        {
            _attachedObj = _x;
            {
                _attachedObj ropeDetach _x;
            } forEach (_vehicle getVariable ["CSA_Tow_Ropes",[]]);
            deleteVehicle _attachedObj;
        } forEach ropeAttachedObjects _vehicle;
        _helper = "Land_Can_V2_F" createVehicle position _player;
        {
            [_helper, [0, 0, 0], [0,0,-1]] ropeAttachTo _x;
            _helper attachTo [_player, [-0.1, 0.1, 0.15], "Pelvis"];
        } forEach (_vehicle getVariable ["CSA_Tow_Ropes",[]]);
        hideObject _helper;
        [[_helper],"CSA_Hide_Object_Global"] call CSA_RemoteExecServer;
        _player setVariable ["CSA_Tow_Ropes_Vehicle", _vehicle,true];
        _player setVariable ["CSA_Tow_Ropes_Pick_Up_Helper", _helper,true];
    } else {
        [_this,"CSA_Pickup_Tow_Ropes",_vehicle,true] call CSA_RemoteExec;
    };
};

CSA_Drop_Tow_Ropes = {
    params ["_vehicle","_player"];
    if(local _vehicle) then {
        private ["_helper"];
        _helper = (_player getVariable ["CSA_Tow_Ropes_Pick_Up_Helper", objNull]);
        if(!isNull _helper) then {
            {
                _helper ropeDetach _x;
            } forEach (_vehicle getVariable ["CSA_Tow_Ropes",[]]);
            detach _helper;
            deleteVehicle _helper;
        };
        _player setVariable ["CSA_Tow_Ropes_Vehicle", nil,true];
        _player setVariable ["CSA_Tow_Ropes_Pick_Up_Helper", nil,true];
    } else {
        [_this,"CSA_Drop_Tow_Ropes",_vehicle,true] call CSA_RemoteExec;
    };
};

CSA_Put_Away_Tow_Ropes = {
    params ["_vehicle","_player"];
    if(local _vehicle) then {
        private ["_existingTowRopes","_hitchPoint","_rope"];
        _existingTowRopes = _vehicle getVariable ["CSA_Tow_Ropes",[]];
        if(count _existingTowRopes > 0) then {
            _this call CSA_Pickup_Tow_Ropes;
            _this call CSA_Drop_Tow_Ropes;
            {
                ropeDestroy _x;
            } forEach _existingTowRopes;
            _vehicle setVariable ["CSA_Tow_Ropes",nil,true];
        };
    } else {
        [_this,"CSA_Put_Away_Tow_Ropes",_vehicle,true] call CSA_RemoteExec;
    };
};

CSA_Attach_Tow_Ropes_Action = {
    private ["_vehicle","_cargo","_canBeTowed"];
    _cargo = cursorTarget;
    _vehicle = player getVariable ["CSA_Tow_Ropes_Vehicle", objNull];
    if([_vehicle,_cargo] call CSA_Can_Attach_Tow_Ropes) then {
        
        _canBeTowed = true;
        
        if!(missionNamespace getVariable ["CSA_TOW_LOCKED_VEHICLES_ENABLED",false]) then {
            if( locked _cargo > 1 ) then {
                ["Cannot attach tow ropes to locked vehicle",false] call CSA_Hint;
                _canBeTowed = false;
            };
        };
        
        if!(missionNamespace getVariable ["CSA_TOW_IN_EXILE_SAFEZONE_ENABLED",false]) then {
            if(!isNil "ExilePlayerInSafezone") then {
                if( ExilePlayerInSafezone ) then {
                    ["Cannot attach tow ropes in safe zone",false] call CSA_Hint;
                    _canBeTowed = false;
                };
            };
        };
    
        if(_canBeTowed) then {
            [_cargo,player] call CSA_Attach_Tow_Ropes;
        };
        
    };
};

CSA_Attach_Tow_Ropes_Action_Check = {
    params ["_cargo"];
    private ["_vehicle"];
    _vehicle = player getVariable ["CSA_Tow_Ropes_Vehicle", objNull];
    _cargo = cursorTarget;
    [_vehicle,_cargo] call CSA_Can_Attach_Tow_Ropes;
};

CSA_Can_Attach_Tow_Ropes = {
    params ["_vehicle","_cargo"];
    if(!isNull _vehicle && !isNull _cargo) then {
        [_vehicle,_cargo] call CSA_Is_Supported_Cargo && vehicle player == player && player distance _cargo < 10 && _vehicle != _cargo;
    } else {
        false;
    };
};

CSA_Take_Tow_Ropes_Action = {
    params ["_vehicle"];
    private ["_canTakeTowRopes"];
    if([_vehicle] call CSA_Can_Take_Tow_Ropes) then {
    
        _canTakeTowRopes = true;
        
        if!(missionNamespace getVariable ["CSA_TOW_LOCKED_VEHICLES_ENABLED",false]) then {
            if( locked _vehicle > 1 ) then {
                ["Cannot take tow ropes from locked vehicle",false] call CSA_Hint;
                _canTakeTowRopes = false;
            };
        };
        
        if!(missionNamespace getVariable ["CSA_TOW_IN_EXILE_SAFEZONE_ENABLED",false]) then {
            if(!isNil "ExilePlayerInSafezone") then {
                if( ExilePlayerInSafezone ) then {
                    ["Cannot take tow ropes in safe zone",false] call CSA_Hint;
                    _canTakeTowRopes = false;
                };
            };
        };
    
        if(_canTakeTowRopes) then {
            [_vehicle,player] call CSA_Take_Tow_Ropes;
        };
    
    };
};


CSA_Can_Take_Tow_Ropes = {
    params ["_vehicle"];
    if([_vehicle] call CSA_Is_Supported_Vehicle) then {
        private ["_existingVehicle","_existingTowRopes"];
        _existingTowRopes = _vehicle getVariable ["CSA_Tow_Ropes",[]];
        _existingVehicle = player getVariable ["CSA_Tow_Ropes_Vehicle", objNull];
        vehicle player == player && player distance _vehicle < 10 && (count _existingTowRopes) == 0 && isNull _existingVehicle && alive _vehicle
    } else {
        false;
    };
};

CSA_Put_Away_Tow_Ropes_Action = {
    params ["_vehicle"];
    private ["_canPutAwayTowRopes"];
    if([_vehicle] call CSA_Can_Put_Away_Tow_Ropes) then {
    
        _canPutAwayTowRopes = true;
        
        if!(missionNamespace getVariable ["CSA_TOW_LOCKED_VEHICLES_ENABLED",false]) then {
            if( locked _vehicle > 1 ) then {
                ["Cannot put away tow ropes in locked vehicle",false] call CSA_Hint;
                _canPutAwayTowRopes = false;
            };
        };
        
        if!(missionNamespace getVariable ["CSA_TOW_IN_EXILE_SAFEZONE_ENABLED",false]) then {
            if(!isNil "ExilePlayerInSafezone") then {
                if( ExilePlayerInSafezone ) then {
                    ["Cannot put away tow ropes in safe zone",false] call CSA_Hint;
                    _canPutAwayTowRopes = false;
                };
            };
        };
    
        if(_canPutAwayTowRopes) then {
            [_vehicle,player] call CSA_Put_Away_Tow_Ropes;
        };
        
    };
};

CSA_Put_Away_Tow_Ropes_Action_Check = {
    params ["_vehicle"];
    [_vehicle] call CSA_Can_Put_Away_Tow_Ropes;
};

CSA_Can_Put_Away_Tow_Ropes = {
    params ["_vehicle"];
    private ["_existingTowRopes"];
    if([_vehicle] call CSA_Is_Supported_Vehicle) then {
        _existingTowRopes = _vehicle getVariable ["CSA_Tow_Ropes",[]];
        vehicle player == player && player distance _vehicle < 10 && (count _existingTowRopes) > 0;
    } else {
        false;
    };
};


CSA_Drop_Tow_Ropes_Action = {
    private ["_vehicle"];
    _vehicle = player getVariable ["CSA_Tow_Ropes_Vehicle", objNull];
    if([] call CSA_Can_Drop_Tow_Ropes) then {
        [_vehicle, player] call CSA_Drop_Tow_Ropes;
    };
};

CSA_Drop_Tow_Ropes_Action_Check = {
    [] call CSA_Can_Drop_Tow_Ropes;
};

CSA_Can_Drop_Tow_Ropes = {
    !isNull (player getVariable ["CSA_Tow_Ropes_Vehicle", objNull]) && vehicle player == player;
};



CSA_Pickup_Tow_Ropes_Action = {
    private ["_nearbyTowVehicles","_canPickupTowRopes","_vehicle"];
    _nearbyTowVehicles = missionNamespace getVariable ["CSA_Nearby_Tow_Vehicles",[]];
    if([] call CSA_Can_Pickup_Tow_Ropes) then {
    
        _vehicle = _nearbyTowVehicles select 0;
        _canPickupTowRopes = true;
        
        if!(missionNamespace getVariable ["CSA_TOW_LOCKED_VEHICLES_ENABLED",false]) then {
            if( locked _vehicle > 1 ) then {
                ["Cannot pick up tow ropes from locked vehicle",false] call CSA_Hint;
                _canPickupTowRopes = false;
            };
        };
        
        if!(missionNamespace getVariable ["CSA_TOW_IN_EXILE_SAFEZONE_ENABLED",false]) then {
            if(!isNil "ExilePlayerInSafezone") then {
                if( ExilePlayerInSafezone ) then {
                    ["Cannot pick up tow ropes in safe zone",false] call CSA_Hint;
                    _canPickupTowRopes = false;
                };
            };
        };
    
        if(_canPickupTowRopes) then {
            [_nearbyTowVehicles select 0, player] call CSA_Pickup_Tow_Ropes;
        };
    
    };
};

CSA_Pickup_Tow_Ropes_Action_Check = {
    [] call CSA_Can_Pickup_Tow_Ropes;
};

CSA_Can_Pickup_Tow_Ropes = {
    isNull (player getVariable ["CSA_Tow_Ropes_Vehicle", objNull]) && count (missionNamespace getVariable ["CSA_Nearby_Tow_Vehicles",[]]) > 0 && vehicle player == player;
};

CSA_TOW_SUPPORTED_VEHICLES = [
    "Tank", "Car", "Ship"
];

CSA_Is_Supported_Vehicle = {
    params ["_vehicle","_isSupported"];
    _isSupported = false;
    if (_vehicle getVariable ["gradTnT_isRepairTank", false]) then {
        _isSupported = true;
    };
    _isSupported;
};

CSA_TOW_RULES = [
    ["Tank","CAN_TOW","Tank"],
    ["Tank","CAN_TOW","Car"],
    ["Tank","CAN_TOW","Ship"],
    ["Tank","CAN_TOW","Air"],
    ["Car","CAN_TOW","Tank"],
    ["Car","CAN_TOW","Car"],
    ["Car","CAN_TOW","Ship"],
    ["Car","CAN_TOW","Air"],
    ["Ship","CAN_TOW","Ship"]
];

CSA_Is_Supported_Cargo = {
    params ["_vehicle","_cargo"];
    private ["_canTow"];
    _canTow = false;
    if(not isNull _vehicle && not isNull _cargo) then {
        {
            if(_vehicle isKindOf (_x select 0)) then {
                if(_cargo isKindOf (_x select 2)) then {
                    if( (toUpper (_x select 1)) == "CAN_TOW" ) then {
                        _canTow = true;
                    } else {
                        _canTow = false;
                    };
                };
            };
        } forEach (missionNamespace getVariable ["CSA_TOW_RULES_OVERRIDE",CSA_TOW_RULES]);
    };
    _canTow;
};

CSA_Hint = {
    params ["_msg",["_isSuccess",true]];
    if(!isNil "ExileClient_gui_notification_event_addNotification") then {
        if(_isSuccess) then {
            ["Success", [_msg]] call ExileClient_gui_notification_event_addNotification; 
        } else {
            ["Whoops", [_msg]] call ExileClient_gui_notification_event_addNotification; 
        };
    } else {
        hint _msg;
    };
};

CSA_Hide_Object_Global = {
    params ["_obj"];
    if( _obj isKindOf "Land_Can_V2_F" ) then {
        hideObjectGlobal _obj;
    };
};

CSA_Set_Owner = {
    params ["_obj","_client"];
    _obj setOwner _client;
};


// CUSTOM by Gruppe Adler: ACE actions instead of MouseWheel
// add to all land vehicles
["LandVehicle", "init", {
    params ["_vehicle"];

    private _deployRopesAction = [
        "deployRopes",
        "Deploy Tow Ropes",
        "\a3\3den\Data\CfgWaypoints\hook_ca.paa",
        {
            [_target] call CSA_Take_Tow_Ropes_Action;
        }, {
            [_target] call CSA_Can_Take_Tow_Ropes
        },{},nil,"",3,[false,false,false,false,false]
    ] call ace_interact_menu_fnc_createAction;

    [_vehicle, 0, ["ACE_MainActions"], _deployRopesAction] call ace_interact_menu_fnc_addActionToObject;


    private _attachRopesAction = [
        "attachRopes",
        "Attach Tow Ropes",
        "\a3\3den\Data\CfgWaypoints\hook_ca.paa",
        {
            [_target] call CSA_Attach_Tow_Ropes_Action;
        }, {
            [_target] call CSA_Attach_Tow_Ropes_Action_Check
        },{},nil,"",3,[false,false,false,false,false]
    ] call ace_interact_menu_fnc_createAction;

    [_vehicle, 0, ["ACE_MainActions"], _attachRopesAction] call ace_interact_menu_fnc_addActionToObject;


    private _putAwayRopes = [
        "putAwayRopes",
        "Put Away Tow Ropes",
        "\a3\3den\Data\CfgWaypoints\unhook_ca.paa",
        {
            [_target] call CSA_Put_Away_Tow_Ropes_Action;
        }, {
            [_target] call CSA_Put_Away_Tow_Ropes_Action_Check
        },{},nil,"",3,[false,false,false,false,false]
    ] call ace_interact_menu_fnc_createAction;

    [_vehicle, 0, ["ACE_MainActions"], _putAwayRopes] call ace_interact_menu_fnc_addActionToObject;

}, true, [], true] call CBA_fnc_addClassEventHandler;

// add self interact actions
private _dropTowRopes  = [
    "dropRopes",
    "Drop Ropes",
    "\A3\ui_f\data\igui\cfg\actions\ico_OFF_ca.paa",
    {
        call CSA_Drop_Tow_Ropes_Action;
    }, {
          call CSA_Can_Drop_Tow_Ropes
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _dropTowRopes ] call ace_interact_menu_fnc_addActionToObject;

CSA_Add_Player_Tow_Actions = {

    player addAction ["Pickup Tow Ropes", { 
        [] call CSA_Pickup_Tow_Ropes_Action;
    }, nil, 0, false, true, "", "call CSA_Pickup_Tow_Ropes_Action_Check"];

    player addEventHandler ["Respawn", {
        player setVariable ["CSA_Tow_Actions_Loaded",false];
    }];
    
};

CSA_Find_Nearby_Tow_Vehicles = {
    private ["_nearVehicles","_nearVehiclesWithTowRopes","_vehicle","_ends","_end1","_end2"];
    _nearVehicles = [];
    {
        if (_x getVariable ["gradTnT_isRepairTank", false]) then {
            _nearVehicles append _x;
        };
    } forEach (position player nearObjects ["LandVehicle", 30]);
    _nearVehiclesWithTowRopes = [];
    {
        _vehicle = _x;
        {
            _ends = ropeEndPosition _x;
            if(count _ends == 2) then {
                _end1 = _ends select 0;
                _end2 = _ends select 1;
                if(((position player) distance _end1) < 5 || ((position player) distance _end2) < 5 ) then {
                    _nearVehiclesWithTowRopes pushBack _vehicle;
                }
            };
        } forEach (_vehicle getVariable ["CSA_Tow_Ropes",[]]);
    } forEach _nearVehicles;
    _nearVehiclesWithTowRopes;
};

if(!isDedicated) then {
    [] spawn {
        while {true} do {
            if(!isNull player && isPlayer player) then {
                if!( player getVariable ["CSA_Tow_Actions_Loaded",false] ) then {
                    [] call CSA_Add_Player_Tow_Actions;
                    player setVariable ["CSA_Tow_Actions_Loaded",true];
                };
            };
            missionNamespace setVariable ["CSA_Nearby_Tow_Vehicles", (call CSA_Find_Nearby_Tow_Vehicles)];
            sleep 2;
        };
    };
};

CSA_RemoteExec = {
    params ["_params","_functionName","_target",["_isCall",false]];
    if(!isNil "ExileClient_system_network_send") then {
        ["AdvancedTowingRemoteExecClient",[_params,_functionName,_target,_isCall]] call ExileClient_system_network_send;
    } else {
        if(_isCall) then {
            _params remoteExecCall [_functionName, _target];
        } else {
            _params remoteExec [_functionName, _target];
        };
    };
};

CSA_RemoteExecServer = {
    params ["_params","_functionName",["_isCall",false]];
    if(!isNil "ExileClient_system_network_send") then {
        ["AdvancedTowingRemoteExecServer",[_params,_functionName,_isCall]] call ExileClient_system_network_send;
    } else {
        if(_isCall) then {
            _params remoteExecCall [_functionName, 2];
        } else {
            _params remoteExec [_functionName, 2];
        };
    };
};

if(isServer) then {
    
    // Adds support for exile network calls (Only used when running exile) //
    
    CSA_SUPPORTED_REMOTEEXECSERVER_FUNCTIONS = ["CSA_Set_Owner","CSA_Hide_Object_Global"];
    
    ExileServer_AdvancedTowing_network_AdvancedTowingRemoteExecServer = {
        params ["_sessionId", "_messageParameters",["_isCall",false]];
        _messageParameters params ["_params","_functionName"];
        if(_functionName in CSA_SUPPORTED_REMOTEEXECSERVER_FUNCTIONS) then {
            if(_isCall) then {
                _params call (missionNamespace getVariable [_functionName,{}]);
            } else {
                _params spawn (missionNamespace getVariable [_functionName,{}]);
            };
        };
    };
    
    CSA_SUPPORTED_REMOTEEXECCLIENT_FUNCTIONS = ["CSA_Simulate_Towing","CSA_Attach_Tow_Ropes","CSA_Take_Tow_Ropes","CSA_Put_Away_Tow_Ropes","CSA_Pickup_Tow_Ropes","CSA_Drop_Tow_Ropes","CSA_Hint"];
    
    ExileServer_AdvancedTowing_network_AdvancedTowingRemoteExecClient = {
        params ["_sessionId", "_messageParameters"];
        _messageParameters params ["_params","_functionName","_target",["_isCall",false]];
        if(_functionName in CSA_SUPPORTED_REMOTEEXECCLIENT_FUNCTIONS) then {
            if(_isCall) then {
                _params remoteExecCall [_functionName, _target];
            } else {
                _params remoteExec [_functionName, _target];
            };
        };
    };

    // Install Advanced Towing on all clients (plus JIP) //
    
    publicVariable "CSA_Advanced_Towing_Install";
    remoteExecCall ["CSA_Advanced_Towing_Install", -2,true];
    
};

diag_log "Advanced Towing Loaded";

};

if(isServer) then {
    [] call CSA_Advanced_Towing_Install;
};
