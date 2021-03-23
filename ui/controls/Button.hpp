import ctrlButton;
class gradTnT_ctrlButton: ctrlButton
{
	w = 5 * EM_W;
	h = 1 * EM_H;
	colorBackground[] = {COLOR_ACCENT, 1};
	colorBackgroundActive[] = {COLOR_PRIMARY, 1};
	colorBackgroundDisabled[] = {COLOR_ACCENT, 0.5};
	colorFocused[] = {COLOR_PRIMARY, 1};
	font = "RobotoCondensed";
	shadow = 0;
	sizeEx = 0.75 * EM_H;
	onLoad = "params ['_c']; _c ctrlSetText ((ctrlText _c) splitString '' joinString ' ');";
};