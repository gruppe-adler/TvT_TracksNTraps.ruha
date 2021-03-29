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
            displayNameShort = "Engineers";
            // Structured text, filled by arguments from 'arguments' param
            description = "<t size='30' shadow='0'><img image='pics\help_engineers.paa'/></t>";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "";
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

        class RepairAbilities
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Repair Abilities";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "Vehicles";
            // Structured text, filled by arguments from 'arguments' param
            description = "To repair a vehicle completely the pioneers need to drive their Bpz close and go into recovery mode (mouse wheel action). This makes their tank an ACE repair vehicle temporarily but leaves the vehicle vulnerable and static. Close vehicles can now be repaired fully.";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "";
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

    class gradTnT_VictoryPoints
    {
        // Topic title (displayed only in topic listbox in Field Manual)
        displayName = "Victory Point System";
        class VictoryPoints
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Victory Point System";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "";
            // Structured text, filled by arguments from 'arguments' param
            description = "Victory Points are accumulated by the following factors:<br/>Holding the flag objective: 100 points per minute<br/>Destroying enemy depot: 2000 points<br/>Destroying enemy bridge: 1000 points<br/>Destroying enemy tank: 500 points<br/>Destroying enemy APC: 300 points<br/>Destroying enemy Car: 100 points<br/>Killing enemy Crewman: 50 points<br/><br/>Note that points are given only AFTER respawn of that entity. This means as long as e.g. a tank can be repaired (no wreck) its not counting as destroyed.<br/>";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "You can destroy/respawn own/enemy tanks instantly by going to their hull and ACE Interact. Time to explosion is 30 seconds. The crew inside will hear metallic sounds if someone tries to attach an explosive. You dont need an actual explosive item to do this.";
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


flagTick = 100;
depotTick = 50;
depot = 2000;
bridge = 1000;
tank = 500;
apc = 300;
car = 100;
crew = 50;

class CfgNotifications
{
    class Default
    {
        title = "";             // Title displayed as text on black background. Filled by arguments.
        iconPicture = "";       // Small icon displayed in left part. Colored by "color", filled by arguments.
        iconText = "";          // Short text displayed over the icon. Colored by "color", filled by arguments.
        description = "";       // Brief description displayed as structured text. Colored by "color", filled by arguments.
        color[] = {1,1,1,1};    // Icon and text color
        duration = 10;           // How many seconds will the notification be displayed
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
        duration = 10;
        sound = "gm_note";
    };

    // Example 2
    class OpforCaptured
    {
        title = "";
        iconPicture = "functions\bft\gui\ico_objective_opfor.paa";
        description = "%1";
        priority = 7;
        duration = 10;
        sound = "gm_note";
    };

    class NeutralCaptured
    {
        title = "";
        iconPicture = "functions\bft\gui\ico_objective_neutral.paa";
        description = "%1";
        priority = 7;
        duration = 10;
        sound = "gm_note";
    };
};
