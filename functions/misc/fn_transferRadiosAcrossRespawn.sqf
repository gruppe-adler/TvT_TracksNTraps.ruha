
// save entire settings array once anything is changed basically
private _fnc_saveSWSettings = {
    params ["_unit"];
    if (_unit != player) exitWith {};
    player setVariable ["gradTnT_tfar_swSettings",(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings];
};
{[_x,_fnc_saveSWSettings] call CBA_fnc_addEventHandler} forEach [
    "TFAR_event_OnSWchannelSet",
    "TFAR_event_OnSWstereoSet",
    "TFAR_event_OnSWvolumeSet",
    "TFAR_event_OnSWChange",
    "TFAR_event_OnSWspeakersSet"
];

// same for longrange
private _fnc_saveLRSettings = {
    params ["_unit"];
    if (_unit != player) exitWith {};
    {
        player setVariable ["gradTnT_tfar_lrSettings",(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings];
    } call CBA_fnc_directCall;
};
{[_x,_fnc_saveLRSettings] call CBA_fnc_addEventHandler} forEach [
    "TFAR_event_OnLRchannelSet",
    "TFAR_event_OnLRstereoSet",
    "TFAR_event_OnLRvolumeSet",
    "TFAR_event_OnLRChange",
    "TFAR_event_OnLRspeakersSet"
];

// frequency changed event gets special treatment, because it fires for both sw and lr
[
    "TFAR_event_OnFrequencyChanged",
    {
        params ["_unit","_radio"];
        if (_unit != player) exitWith {};

      
        private _activeSw = call TFAR_fnc_activeSwRadio;
        if (_activeSw isEqualTo _radio) exitWith {
            player setVariable ["gradTnT_tfar_swSettings",(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings];
        };

        private _activeLr = call TFAR_fnc_activeLRRadio;
        if (_activeLr isEqualTo _radio) exitWith {
            {
                player setVariable ["gradTnT_tfar_lrSettings",(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings];
            } call CBA_fnc_directCall;
        };
    
    }
] call CBA_fnc_addEventHandler;

// apply SR settings every time a radio is instanced
[
    "TFAR_event_OnRadiosReceived",
    {
        params ["_unit","_radio"];

        
        if (_unit != player) exitWith {};
        _radio params ["_firstRadio"];
        _radioClass = getText (configFile >> "CfgWeapons" >> _firstRadio >> "tf_parent");
        
        private _settings = player getVariable ["gradTnT_tfar_swSettings",[]];
        if (count _settings > 0) then {
            [call TFAR_fnc_activeSwRadio, _settings] call TFAR_fnc_setSwSettings; 
        };
        player setVariable ["tf_receivingDistanceMultiplicator", 0.25];
        player setVariable ["tf_sendingDistanceMultiplicator", 4];

        

    }
] call CBA_fnc_addEventHandler;

// apply LR settings every time a new loadout is applied
[
    "grad_loadout_loadoutApplied",
    {
        params ["_unit","_loadout"];
        if (_unit != player) exitWith {};

        private _backpack = (_loadout param [5,[]]) param [0,""];
        if !(_backpack call TFAR_fnc_isLRRadio) exitWith {};

        private _settings = player getVariable ["gradTnT_tfar_lrSettings",[]];
        if (count _settings > 0) then {
            [
                {
                    params ["_unit","_backpack"];
                    backpack _unit == _backpack
                },
                {
                    params ["_unit","","_settings"];
                    
                    if (canSuspend) exitWith {
                        {[TFAR_fnc_setLrSettings, _settings]} call CBA_fnc_directCall;
                    };
                },
                [_unit,_backpack,_settings],
                5
            ] call CBA_fnc_waitUntilAndExecute;
        };
    }
] call CBA_fnc_addEventHandler;
