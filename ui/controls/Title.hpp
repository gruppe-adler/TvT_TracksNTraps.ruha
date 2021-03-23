class gradTnT_ctrlTitle: gradTnT_ctrlStatic
{
	colorText[] = {COLOR_ACCENT, 1};
	sizeEx = 0.65 * EM_H;
	style = 0x02; // ST_CENTER
	h = 1 * EM_H;
	moving = 1;
	onLoad = "params ['_c']; _c ctrlSetText ((ctrlText _c) splitString '' joinString ' ');"
};