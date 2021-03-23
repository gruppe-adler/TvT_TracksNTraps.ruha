
#define FORM_W (30 * GRID_W)
#define FORM_H (4 * EM_H + FIELD_SPACING_H)
#define FIELD_W ((FORM_W - 1 * GRID_W) / 2)

#define DIALOG_W (GRID_W * 60)
#define DIALOG_H (GRID_H * 32)

#define FIELDS_X (DIALOG_W - FORM_W) / 2

class gradTnT_changeVehicleCallsign {
	idd = -1;
	movingEnable = 1;
	class ControlsBackground {
        #define LAYOUT_W DIALOG_W
        #define LAYOUT_H DIALOG_H
		#define LAYOUT_HEADING "CHANGE VEHICLE ID"
		#include "..\utils\GenerateLayout.hpp"
	};
	class Controls {
		class wrapper: ctrlControlsGroupNoScrollbars {
			x = CENTER_X(DIALOG_W);
			y = CENTER_Y(DIALOG_H) + DIALOG_H - (FORM_H + FIELD_SPACING_H);
			w = DIALOG_W;
			h = FORM_H;
			class Controls {
				class prefix: gradTnT_ctrlCombo {
					w = FIELD_W;
					x = FIELDS_X;
					y = 0;
					idc = 1337;
				};
				class suffix: prefix {
					x  = FIELDS_X + FORM_W - FIELD_W;
					idc = 1338;
				};
				class number: gradTnT_ctrlEdit {
					idc = 1339;
					w = FIELD_W;
					x = FIELDS_X;
					style = 0x02 + 0x0200; // ST_CENTER + ST_NO_RECT
					y  = 1 * EM_H + FIELD_SPACING_H;
					maxChars = 4;
				};
				class labelID: gradTnT_ctrlLabel {
					x = 0;
					y = 0;
					w = FIELDS_X;
					text = "ID";
				};
				class labelNumber: labelID {
					x = 0;
					y = 1 * EM_H + FIELD_SPACING_H;
					w = FIELDS_X;
					text = "NUMBER";
				};
				class save: gradTnT_ctrlButton {
					x  = FIELDS_X;
					y = FORM_H - 1 * EM_H;
					w = FORM_W;
					text = "SAVE";
					idc = 1;
					default = 1;
				};
			};
		};
	};
};

#undef FIELDS_X
#undef FORM_W
#undef FORM_H
#undef FIELD_W
#undef DIALOG_H
#undef DIALOG_W