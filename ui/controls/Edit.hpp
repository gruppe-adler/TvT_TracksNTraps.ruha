import ctrlEdit;
class gradTnT_ctrlEdit: ctrlEdit
{
	style = 0x0200; // ST_NO_RECT
	colorBackground[] = {COLOR_FIELD_BACKGROUND, 1};
	colorText[] = {COLOR_TEXT, 1};
	colorDisabled[] = {COLOR_TEXT, 0.25};
	colorSelection[] = {COLOR_ACCENT, 1};
	h = 1 * EM_H;
	w = 10 * EM_W;
	lines = 0;
	sizeEx = 0.95 * EM_H;
	shadow = 0;
	font = "RobotoCondensed";
};
