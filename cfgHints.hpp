class CfgHints
{
    class gradTnT_Engineer
    {
        // Topic title (displayed only in topic listbox in Field Manual)
        displayName = "Engineer System";
        class BuildingAbilities
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Building Abilities";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "...";
            // Structured text, filled by arguments from 'arguments' param
            description = "Hello %11! You belong to the engineers team.<br/><t size='10' shadow='0'><img image='pics\help_engineers.paa'/></t>";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "Find a description of your abilities in the %3FIELD MANUAL%4 you find in the ESC menu.";
            arguments[] = {
                "name player" // Simple string will be simply compiled and called, String can also link to localization database in case it starts by str_
            };
            // Optional image
            image = "pics\logo_tracksntraps.paa";
            // optional parameter for not showing of image in context hint in mission (default false))
            noImage = false;
            // -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
            // if a dlc's appID Number is used ( see [[getDLCs]] ) and the user does not have the required dlc installed then the advHint will be replaced with
            // configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
            dlc = 0;
        };
    };
};

class CfgNotifications
{
    class Default
    {
        title = "";             // Title displayed as text on black background. Filled by arguments.
        iconPicture = "";       // Small icon displayed in left part. Colored by "color", filled by arguments.
        iconText = "";          // Short text displayed over the icon. Colored by "color", filled by arguments.
        description = "";       // Brief description displayed as structured text. Colored by "color", filled by arguments.
        color[] = {1,1,1,1};    // Icon and text color
        duration = 5;           // How many seconds will the notification be displayed
        priority = 0;           // Priority; higher number = more important; tasks in queue are selected by priority
        difficulty[] = {};      // Required difficulty settings. All listed difficulties has to be enabled        
        sound = "scoreAdded";
        soundClose = "scoreRemoved";
    };

    // Example 1
    class BluforCaptured
    {
        title = "";
        iconPicture = "functions\bft\gui\ico_objective_blufor.paa";
        description = "%1";
        priority = 7;
        sound = "gm_note";
    };

    // Example 2
    class OpforCaptured
    {
        title = "";
        iconPicture = "functions\bft\gui\ico_objective_opfor.paa";
        description = "%1";
        priority = 7;
        sound = "gm_note";
    };

    class NeutralCaptured
    {
        title = "";
        iconPicture = "functions\bft\gui\ico_objective_neutral.paa";
        description = "%1";
        priority = 7;
        sound = "gm_note";
    };
};