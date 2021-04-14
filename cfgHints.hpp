class CfgHints
{
    class gradTnT_RoleLogistics
    {
        displayName = "Roles: Logistics";
        class Abilities
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Abilities";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "";
            // Structured text, filled by arguments from 'arguments' param
            description = "The engineer's job is to keep the armored vehicles %3repaired, refueled and rearmed%4.%1To accomplish this, he can build %3support structures%4 and %3fortifications%4 such as depots, bridges and tank traps using his recovery tank. In addition, he can perform field repairs.%1%1Field Repair%1%2Can %3repair%4 vehicles in the field to a functional level using a %3toolbox%4.%1%2Uses the regular %3ACE Repair system%4.%1%2Components need to be repaired individually.%1%2Tracks and wheels need to repaired using %3spare tracks/wheels%4. Usually each vehicle carries some of those in their cargo inventory.";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "";
            arguments[] = { // Simple string will be simply compiled and called, String can also link to localization database in case it starts by str_
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
        class BuildingAbilities
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Recovery tank";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "";
            // Structured text, filled by arguments from 'arguments' param
            description = "<t size='30' shadow='0'><img image='pics\help_engineers.paa'/></t>%1The recovery tank has to be in close proximity and in %3recovery mode%4 to build any of the above structures or perform %3full repairs%4.%1%3Recovery%4 mode can be entered/exited using mouse wheel actions.%1In recovery mode, the tank becomes %3immovable%4.%1%1%2When in recovery mode, a dismounted engineer can use %3ACE Interact -> Repair -> Full Repair%4 to %3fully repair%4 vehicles in close proxmity without a depot nearby.%1%1Neither you yourself nor your recovery tank not need to remain close to the depot for others to be able to resupply vehicles there.";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "";
            arguments[] = { // Simple string will be simply compiled and called, String can also link to localization database in case it starts by str_
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
            displayName = "How to win";
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "";
            // Structured text, filled by arguments from 'arguments' param
            description = "To win, your faction must accumulate more victory points than the enemy.%1%2Holding the flag objective: 100 points per minute%1%2Destroying enemy depot: 2000 points%1%2Destroying enemy bridge: 1000 points%1%2Destroying enemy tank: 500 points%1%2Destroying enemy APC: 300 points%1%2Destroying enemy Car: 100 points%1%2Killing enemy Crewman: 50 points%1%1Note that points are only rewarded AFTER the vehicle respawns. This means as long as it can be repaired (no wreck model) its not counting as destroyed.";
            // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
            tip = "You can destroy/respawn own/enemy tanks instantly by using %3ACE Interact -> Plant explosive %4 on the vehicle hull. After the specified time, the vehicle will explode. The crew will hear metallic clangs while someone tries to attach an explosive. You don't need an actual explosive item to do this.";
            arguments[] = {
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
        iconPicture = "functions\flag\data\ico_objective_blufor.paa";
        description = "%1";
        priority = 7;
        duration = 10;
        sound = "gm_note";
    };

    // Example 2
    class OpforCaptured
    {
        title = "";
        iconPicture = "functions\flag\data\ico_objective_opfor.paa";
        description = "%1";
        priority = 7;
        duration = 10;
        sound = "gm_note";
    };

    class NeutralCaptured
    {
        title = "";
        iconPicture = "functions\flag\data\ico_objective_neutral.paa";
        description = "%1";
        priority = 7;
        duration = 10;
        sound = "gm_note";
    };
};
