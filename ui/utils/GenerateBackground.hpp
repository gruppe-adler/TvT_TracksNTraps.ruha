/*
Usage:

1. Define the following properties as you would usualy set w / h / x / y
	BACKGROUND_W	// Background width
	BACKGROUND_H	// Background height

2. Optionally you can define an x and  y position. If those are not set the background will be centered within the screen:
	BACKGROUND_X	// Background x pos
	BACKGROUND_Y	// Background y pos

3. Include this file

4. You don't need to think about undefining your variables, this hpp already handles cleanup.

Example:
	#define BACKGROUND_X (safezoneX + safezoneW / 2 - 50 * pixelW)
	#define BACKGROUND_Y (safezoneY + safezoneH / 2 - 50 * pixelH)
	#define BACKGROUND_W (100 * pixelW)
	#define BACKGROUND_H (100 * pixelH)
	#include "GenerateBackground.hpp"
*/

// FALLBACK VALUES
#ifndef BACKGROUND_W
	#define BACKGROUND_W 1
#endif
#ifndef BACKGROUND_H
	#define BACKGROUND_H 1
#endif
#ifndef BACKGROUND_X
	#define BACKGROUND_X CENTER_X(BACKGROUND_W)
#endif
#ifndef BACKGROUND_Y
	#define BACKGROUND_Y CENTER_Y(BACKGROUND_H)
#endif

// HELPER DEFINES
#define CORNER_W (BACKGROUND_CORNER_RADIUS * pixelW)
#define CORNER_H (BACKGROUND_CORNER_RADIUS * pixelH)

// top left corner
class backgroundCornerTL: gradTnT_ctrlBackgroundCornerTL {
	x = BACKGROUND_X;
	y = BACKGROUND_Y;
};
// top right corner
class backgroundCornerTR: gradTnT_ctrlBackgroundCornerTL {
	x = BACKGROUND_X + BACKGROUND_W - CORNER_W;
	y = BACKGROUND_Y;
	angle = 90;
};
// bottom right corner
class backgroundCornerBR: gradTnT_ctrlBackgroundCornerTL {
	x = BACKGROUND_X + BACKGROUND_W - CORNER_W;
	y = BACKGROUND_Y + BACKGROUND_H - CORNER_H;
	angle = 180;
};
// bottom left corner
class backgroundCornerBL: gradTnT_ctrlBackgroundCornerTL {
	x = BACKGROUND_X;
	y = BACKGROUND_Y + BACKGROUND_H - CORNER_H;
	angle = 270;
};
// background between top left and bottom left corner
class backgroundLeft: gradTnT_ctrlBackground {
	x = BACKGROUND_X;
	y = BACKGROUND_Y + CORNER_H;
	w = CORNER_W;
	h = BACKGROUND_H - 2 * CORNER_H;
};
// background between top right and bottom right corner
class backgroundRight: gradTnT_ctrlBackground {
	x = BACKGROUND_X + BACKGROUND_W - CORNER_W;
	y = BACKGROUND_Y + CORNER_H;
	w = CORNER_W;
	h = BACKGROUND_H - 2 * CORNER_H;
};
// background for the rest 
class backgroundMain: gradTnT_ctrlBackground {
	x = BACKGROUND_X + CORNER_W;
	y = BACKGROUND_Y;
	w = BACKGROUND_W - 2 * CORNER_W;
	h = BACKGROUND_H;
};

// We don't want to pollute the following code, so we'll delete all defines
#undef CORNER_W
#undef CORNER_H
#undef BACKGROUND_X
#undef BACKGROUND_Y
#undef BACKGROUND_W
#undef BACKGROUND_H