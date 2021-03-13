import RscMapControl;
import RscStructuredText;
import RscButton;

class gradTnT_taxiDialog
{
        idd = -1;
        movingenable = 0;

        enableSimulation = 1;
        enableDisplay = 1;
        onLoad = "uiNamespace setVariable ['gradTnT_taxiDialog_display', (_this select 0)];";
        fadein = 0.25;
        fadeout = 0.25;
        controls[] = { btn_taxiDialog_cancel, btn_taxiDialog_choose, btn_taxiDialog_exitMenu  };

        class controlsBackground
            {
                class gradTnT_taxiDialog_map : RscMapControl
                {
                            idc = -1;
                            maxSatelliteAlpha = 0;
                            x = GUI_GRID_X;
                            y = GUI_GRID_Y;
                            w = 40 * GUI_GRID_W;
                            h = 25 * GUI_GRID_H;
                            onLoad = "(_this select 0) ctrlShow false; uiNamespace setVariable ['gradTnT_taxiDialog_map', (_this select 0)];";
                };

                class RscText_map_headline : RscStructuredText {
                    idc = -1;
                    text = "<t size='4' shadow='0' align='center'>Taxi</t>";
                    color[] = {1,1,1,0.3};
                    x = safeZoneX + (safeZoneX + safeZoneW)/5;
                    y = safeZoneY + (safeZoneY + safeZoneH)/20;
                    w = safeZoneX + safeZoneW;
                    h = safeZoneH/10;
                    colorBackground[] = {0,0,0,0.2};
                };


            };

        class btn_taxiDialog_cancel: RscButton
        {
                idc = -1;
                text = "Abbrechen";
                x = GUI_GRID_X;
                y = safeZoneY + (safeZoneY + safeZoneH)/20;
                w = 10 * GUI_GRID_W;
                h = 3 * GUI_GRID_H;
                colorText[] = {1,1,1,0.8};
                colorBackground[] = {0,0,0,0.7};
                tooltip = "";
                onButtonClick = "[] call gradTnT_fnc_taxiCloseMap;  diag_log 'cancel click'; ";
                onLoad = "(_this select 0) ctrlShow false; uiNamespace setVariable ['gradTnT_taxiDialog_btn_cancel', (_this select 0)];";
        };

        class btn_taxiDialog_exitMenu: RscButton
        {
                idc = -1;
                text = "Menü schließen";
                x = GUI_GRID_X;
                y = safeZoneY + (safeZoneY + safeZoneH)/20;
                w = 10 * GUI_GRID_W;
                h = 3 * GUI_GRID_H;
                colorText[] = {1,1,1,0.8};
                colorBackground[] = {0,0,0,0.7};
                tooltip = "";
                onButtonClick = "[] call gradTnT_fnc_taxiDialogClose; diag_log 'exitmenu click'; ";
                onLoad = "uiNamespace setVariable ['gradTnT_taxiDialog_btn_exitMenu', (_this select 0)];";
        };

        class btn_taxiDialog_choose: RscButton
        {
                idc = -1;
                text = "Ziel wählen";
                x = GUI_GRID_X + (GUI_GRID_W * 30);
                y = safeZoneY + (safeZoneY + safeZoneH)/20;
                w = 10 * GUI_GRID_W;
                h = 3 * GUI_GRID_H;
                colorText[] = {0,0,0,1};
                colorBackground[] = {0.81,0.55,0.12,1};
                tooltip = "";
                onButtonClick = "[] call gradTnT_fnc_taxiOpenMap; diag_log 'choosebtn click'; ";
                onLoad = "uiNamespace setVariable ['gradTnT_taxiDialog_btn_choose', (_this select 0)];";
        };

      
};