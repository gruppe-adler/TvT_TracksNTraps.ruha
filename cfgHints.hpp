class CfgHints
{
        class gradTnT_General
    {
        displayName = "General";
        logicalOrder = 1;
        class GoodToKnow
        {
            // Hint title, filled by arguments from 'arguments' param
            displayName = "Good to know";
            // Optional. Can be used to force the display order in the list.
            logicalOrder = 1;
            // Optional hint subtitle, filled by arguments from 'arguments' param
            displayNameShort = "";
            // Structured text, filled by arguments from 'arguments' param
            description = "In %3Tracks'n'Traps%4, all armored vehicles are much less likely to explode after a few hits. Modules are still damaged and crew can still be killed, rendering vehicles unusable, but without destroying the vehicle itself.%1Vehicle-kills only award points once they explode or are forcibly respawned by the owning faction.%1These changes promote %3teamplay%4 and %3logistics%4. When your tank is disabled, you have the option to bring in your engineers to make your vehicle combat-ready again without losing any points, instead of forcibly respawning the vehicle and starting from base.%1%1%2Everyone has access to GPS and at least a short range radio.%1%2You can %3manage your groups%4 using the dynamic groups (default U) menu, as well as your Blufor Tracker (BFT) %3callsign%4 using ACE Interact at your vehicle.%1%2%3Unflipping%4 vehicles using ACE Interact requires at least two people.%1%2%3Foliage%4 and %3camonets%4 on vehicles can be detached.%1%2No one has %3thermal vision%4.%1%2You are not allowed to leave the marked %3battle area%4.%1%2You are not allowed to pick up %3enemy radios%4.%1%2There is no %3AT infantry%4.%1%2%3Existing bridges%4 can be destroyed using ACE Interact atop the center of the bridge.";
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
        class VictoryPoints
        {
            displayName = "How to win";
            logicalOrder = 2;
            displayNameShort = "";
            description = "To win, your faction must accumulate more victory points than the enemy.%1%2Holding the flag objective: 100 points per minute%1%2Destroying enemy depot: 2000 points%1%2Destroying enemy bridge: 1000 points%1%2Destroying enemy tank: 500 points%1%2Destroying enemy APC: 300 points%1%2Destroying enemy Car: 100 points%1%2Killing enemy Crewman: 50 points%1%1Points are only awarded %3AFTER%4 the vehicle respawns. This means as long as it can be repaired (no wreck model) its not counting as destroyed.%1%1Control of the flag objective can only be achieved by moving a %3recovery tank%4 close to the flag pole. However, %3any vehicle%4 can be used to neutralize (lower) the flag to prevent the enemy from scoring points.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
        class gradTnT_RespawnSystem
        {
            displayName = "Vehicle Respawn";
            logicalOrder = 3;
            displayNameShort = "";
            description = "If you die, you can always respawn at base. You can also respawn at the depot (if placed), but you will not be able to spawn vehicles or the AI taxi there.%1%1You can decide to try and recover the vehicle in the field. This has the advantage of the enemy %3not gaining points%4 for the vehicle kill. If recovery of the vehicle is impossible, you can respawn any vehicle you previously occupied at the %3base flagpole%4. This will award the enemy points for the vehicle kill.";
            tip = "You can destroy your own and hostile tanks instantly by using %3ACE Interact > Plant explosive%4 on the vehicle hull. After the specified time, the vehicle will explode. The crew will hear metallic clangs while someone tries to attach an explosive. You don't need an actual explosive item to do this.";
            image = "pics\logo_tracksntraps.paa";
        };
        class gradTnT_AITaxi
        {
            displayName = "AI Taxi";
            logicalOrder = 4;
            displayNameShort = "";
            description = "You can request an %3AI taxi%4 at the flagpole in base. This will spawn a jeep with an AI driver. When you get in, a popup will ask you to click on your destination. The driver will then take you there.%1This is useful when only part of a vehicle crew has been killed and you need to meet up with your vehicle and the rest of the crew.";
            tip = "Bear in mind that this is the regular AI driving. They will take roads whenever possible and not drive straight to your destination. They will also not detour enemies or minefields.";
            image = "pics\logo_tracksntraps.paa";
        };
        class gradTnT_BluforTracker
        {
            displayName = "Blufor Tracker";
            logicalOrder = 5;
            displayNameShort = "";
            description = "This mission features a detailed Blufor tracker.%1%2Only %3vehicles%4 are shown.%1%2%3Empty dots%4 above the vehicle icon show the crew capacity.%1%2%3Filled dots%4 show how many slots are crewed in the vehicle.%1%2Vehicles have a %3formation marker%4 on the hull (can be obscured by attached by camo or foliage). This can be changed using ACE Interact on the vehicle.%1%2The %3objective and its current owner%4 will always be shown.%1%2%4Depot and bridges%4 built by your engineers will always be shown.%1%2Completely %3destroyed vehicles%4 are shown with a fading explosion-marker. Wrecks persist on terrain.%1%2%3Rivers and creeks%4 are highlighted on the BluforTracker to prevent drowning accidents.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
    };
    class gradTnT_Role
    {
        displayName = "Roles";
        logicalOrder = 2;
        class gradTnT_RoleTanker
        {
            displayName = "Tanker";
            logicalOrder = 1;
            displayNameShort = "";
            description = "The tanker's job is to engage the enemy and clear the way to the control point. You have access to your faction's armored vehicles.%1%2Check %3Good to Know%4 for some information about your abilities.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
        class gradTnT_RoleRecon
        {
            displayName = "Recon";
            logicalOrder = 2;
            displayNameShort = "";
            description = "The recon's job is to %3scout enemy movements%4 and %3disrupt%4 them. They have access to comaparably lightly armored, fast and quiet vehicles such as the %3BTR, BMP, Luchs and Marder%4.%1The BTR, BMP and Luchs are %3amphibious%4. The Marder is not, but has more powerful armament.%1%1%2Can plant %3AT mines%4%1%2Can build %3tank traps%4 (retrieve from logistic depot) using ACE Interact->Fortifications";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
        class gradTnT_RolePilot
        {
            displayName = "Pilot";
            logicalOrder = 3;
            displayNameShort = "";
            description = "The pilot's job is to %3scout enemy movements%4. They have access to an unarmed light scout helicopter. They have no special abilities.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
    }
    class gradTnT_RoleLogistics
    {
        displayName = "Roles: Logistics";
        logicalOrder = 3;
        class Abilities
        {
            displayName = "Abilities";
            logicalOrder = 1;
            displayNameShort = "";
            description = "The engineer's job is to keep the armored vehicles %3repaired, refueled and rearmed%4.%1To accomplish this, he can build %3support structures%4 and %3fortifications%4 such as depots, bridges and tank traps using his recovery tank. In addition, he can perform field repairs.%1%1Field Repair%1%2Can %3repair%4 vehicles in the field to a functional level using a %3toolbox%4.%1%2Uses the regular %3ACE Repair system%4.%1%2Components need to be repaired %3individually%4.%1%2Tracks and wheels need to repaired using %3spare tracks/wheels%4. Usually each vehicle carries some of those in their cargo inventory.%1%1Abilities%1%2Engineers can place and remove tank traps and AT mines (hostile ones as well).%1%2Tank traps and mines cannot be placed inside the green objective radius.%1%2Engineers are also trained medics and can offer full treatment to any injured personnel.%1%2Medical equipment is available in all vehicles.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
        };
        class BuildingAbilities
        {
            displayName = "Recovery tank";
            logicalOrder = 2;
            displayNameShort = "";
            description = "<t size='30' shadow='0'><img image='pics\help_engineers.paa'/></t>%1%2The recovery tank has to be in close proximity and in %3recovery mode%4 to build any of the above structures or perform %3full repairs%4.%1%2%3Recovery%4 mode can be entered/exited using mouse wheel actions.%1%2In recovery mode, the tank becomes %3immovable%4.%1%2In recovery mode, a dismounted engineer can use %3ACE Interact > Repair > Full Repair%4 to %3fully repair%4 vehicles in close proxmity without a depot nearby.%1%2Neither you nor your recovery tank need to remain close to a depot for others to be able to resupply vehicles there.%1%2The recovery tank is the only vehicle that can raise the flag at the control point. It does NOT have to be manned by engineers to do so.";
            tip = "";
            image = "pics\logo_tracksntraps.paa";
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
