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