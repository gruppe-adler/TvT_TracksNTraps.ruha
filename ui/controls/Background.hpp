class gradTnT_ctrlBackground: gradTnT_ctrlStatic {
	colorBackground[] = {COLOR_BACKGROUND, 1};
	x = 0;
	y = 0;
	w = 1;
	h = 1;
};

class gradTnT_ctrlBackgroundCornerTL: gradTnT_ctrlStatic {
	style = 0x30; // ST_PICTURE
	colorText[] = {COLOR_BACKGROUND, 1};
	x = 0;
	y = 0;
	w = BACKGROUND_CORNER_RADIUS * pixelW;
	h = BACKGROUND_CORNER_RADIUS * pixelH;
	text = QASSET(controls\background\corner_ca.paa);
};
