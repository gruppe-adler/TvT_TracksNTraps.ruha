["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework and registers the player group
[] call grad_groupsettings_fnc_setGroupSettings;

// add ace interact node for engineers to put their building stuff into
// is centralized
if (player getVariable ["ACE_IsEngineer", 0] > 0) then {
    private _action = ["Engineer_Buildings", "Engineer Buildings", "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    player setVariable ["gradTnT_engineerNodeAdded", true];
    player setVariable ["gradTnT_isEngineer", true, true];
};

0 enableChannel false; // Disable user ability to send voice and text on global channel

// disable penalties for blue on blue
player addEventHandler ["HandleRating", {
	params ["_unit", "_rating"];
  0
}];
