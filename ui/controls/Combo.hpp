import ctrlCombo;
class gradTnT_ctrlCombo: ctrlCombo
{
	style = 0x0200 + 0x10; // ST_NO_RECT + ST_MULTI
	colorBackground[] = {COLOR_FIELD_BACKGROUND, 1};
	h = 1 * EM_H;
	w = 3 * EM_W;
	colorSelectBackground[] = {COLOR_TEXT, 1};
	colorText[] = {COLOR_TEXT, 1};
	colorDisabled[] = {COLOR_TEXT, 0.25};
	colorSelect[] = {COLOR_FIELD_BACKGROUND, 1};
	colorTextRight[] = {COLOR_TEXT, 1};
	colorSelectRight[] = {COLOR_TEXT, 0.25};
	colorSelect2Right[] = {COLOR_TEXT, 1};
	colorPicture[] = {COLOR_TEXT, 1};
	colorPictureSelected[] = {COLOR_TEXT, 1};
	colorPictureDisabled[] = {COLOR_TEXT, 0.25};
	colorPictureRight[] = {COLOR_TEXT, 1};
	colorPictureRightSelected[] = {COLOR_TEXT, 1};
	colorPictureRightDisabled[] = {COLOR_TEXT, 0.25};
	arrowEmpty = QASSET(controls\combo\arrowEmpty_ca.paa);
	arrowFull = QASSET(controls\combo\arrowFull_ca.paa);
	wholeHeight= 7 * EM_H;
	sizeEx = 0.95 * EM_H;
	font = "RobotoCondensed";
	shadow = 0;
	class ComboScrollBar: gradTnT_ctrlScrollBar {};
};
