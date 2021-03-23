class gradTnT_ctrlButtonClose: gradTnT_ctrlButton {
	idc = 2;
	style = 0x30; // ST_PICTURE
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	w = 32 * pixelW;
	h = 32 * pixelH;
	// onLoads EH just sets the correct texture. I wish I could just set this with the text property,
	// but this seems bugged with picutre-buttons atm. If i set the type to 0 (static), then everything
	// works fine, but with type = 1 (button) Arma cannot resolve the relative path
	onLoad = QUOTE((_this select 0) ctrlSetText (getMissionPath 'ASSET(controls\closeButton\close_ca.paa)'));
};
