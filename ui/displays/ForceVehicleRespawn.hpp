
#define FORM_WIDTH (30 * GRID_W)

#define DIALOG_W (GRID_W * 60)
#define DIALOG_H (GRID_H * 60)

class gradTnT_forceVehicleRespawn {
	idd = -1;
	movingEnable = 1;
	class ControlsBackground {
        #define LAYOUT_W DIALOG_W
        #define LAYOUT_H DIALOG_H
		#define LAYOUT_HEADING "FORCE VEHICLE RESPAWN"
		#include "..\utils\GenerateLayout.hpp"
	};
	class Controls {
		class vehicle: gradTnT_ctrlCombo {
			x = CENTER_X(DIALOG_W) + FIELD_SPACING_W;
			y = CENTER_Y(DIALOG_H) + 10 * GRID_H;
			w = DIALOG_W - FIELD_SPACING_W * 2;
			default = 1;
			idc = 1337;
		};
		class map: ctrlMap {
			w = DIALOG_W - FIELD_SPACING_W * 2;
			x = CENTER_X(DIALOG_W) + FIELD_SPACING_W;
			y = CENTER_Y(DIALOG_H) + 10 * GRID_H + 1 * EM_H + FIELD_SPACING_H;
			h = 7 * EM_H;
			idc = 1338;

			class Legend {
				x = 0;
				y = 0;
				w = 0;
				h = 0;
				font = "RobotoCondensed";
				sizeEx = 0;
				colorBackground[] = {0, 0, 0, 0};
				color[] = {0, 0, 0, 0};
			};
		};
		class save: ctrlShortcutButton {
			x = CENTER_X(FORM_WIDTH);
			y = CENTER_Y(DIALOG_H) + 10 * GRID_H + 8 * EM_H + 2 * FIELD_SPACING_H;
			w = FORM_WIDTH;
			h = 1 * EM_H;
			text = "RESPAWN";
			idc = 1;
			size = 0.75 * EM_H;
			onLoad = "params ['_c']; _c ctrlSetText ((ctrlText _c) splitString '' joinString ' ');";

			class Attributes {
				align = "center";
				color = "#FFFFFF";
				font = "RobotoCondensed";
				shadow = 0;
			};

			class TextPos {
				bottom = 0;
				left = 0;
				right = 0;
				top = 0.125 * EM_H;
			};

			// default text color
			color[] = {COLOR_TEXT, 0.9};

			// text color will fade between those on hover / focus
			color2[] = {COLOR_TEXT, 1};
			colorFocused[] = {COLOR_TEXT, 1};

			// default background color
			colorBackground[] = {COLOR_WARNING, 0.9};

			// background color will fade between those on hover / focus
			colorBackground2[] = {COLOR_WARNING, 1};
			colorBackgroundFocused[] = {COLOR_WARNING, 1};
		};
		class hint: gradTnT_ctrlStatic {
			show = 0;
			x = CENTER_X(DIALOG_W) + FIELD_SPACING_W;
			y = CENTER_Y(DIALOG_H) + 10 * GRID_H + 8 * EM_H + 2 * FIELD_SPACING_H;
			w = DIALOG_W - FIELD_SPACING_W * 2;
			h = 1 * EM_H;
			sizeEx = 0.5 * EM_H;
			style = 0x02;
			idc = 1339;
			text = "You can only respawn empty vehicles.";
		};
	};
};

#undef FIELDS_X
#undef FORM_WIDTH
#undef DIALOG_H
#undef DIALOG_W