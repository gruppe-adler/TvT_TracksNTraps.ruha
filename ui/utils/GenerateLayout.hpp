/*
Usage:

1. Define the following properties as you would usualy set w / h / x / y
	LAYOUT_W	// Background width
	LAYOUT_H	// Background height

2. Optionally you can define an x and  y position. If those are not set the background will be centered within the screen:
	LAYOUT_X		// LAYOUT x pos
	LAYOUT_Y		// LAYOUT y pos 
	LAYOUT_HEADING	// STRING which is heading

3. Include this file

4. You don't need to think about undefining your variables, this hpp already handles cleanup.

Example:
	#define LAYOUT_X (safezoneX + safezoneW / 2 - 50 * pixelW)
	#define LAYOUT_Y (safezoneY + safezoneH / 2 - 50 * pixelH)
	#define LAYOUT_W (100 * pixelW)
	#define LAYOUT_H (100 * pixelH)
	#include "GenerateBackground.hpp"
*/

// FALLBACK VALUES
#ifndef LAYOUT_W
	#define LAYOUT_W 1
#endif
#ifndef LAYOUT_H
	#define LAYOUT_H 1
#endif
#ifndef LAYOUT_X
	#define LAYOUT_X CENTER_X(LAYOUT_W)
#endif
#ifndef LAYOUT_Y
	#define LAYOUT_Y CENTER_Y(LAYOUT_H)
#endif

// background
#define BACKGROUND_X LAYOUT_X
#define BACKGROUND_Y LAYOUT_Y
#define BACKGROUND_W LAYOUT_W
#define BACKGROUND_H LAYOUT_H
#include "GenerateBackground.hpp"

#ifdef LAYOUT_HEADING 
class title: gradTnT_ctrlTitle {
	x = LAYOUT_X;
	y = LAYOUT_Y;
	w = LAYOUT_W;
	text = LAYOUT_HEADING;
};
#endif

class logo: gradTnT_ctrlLogo {
	x = LAYOUT_X + 8 * pixelW;
	y = LAYOUT_Y + 8 * pixelH;
};

class btnClose: gradTnT_ctrlButtonClose {
	x = LAYOUT_X + LAYOUT_W - 40 * pixelW;
	y = LAYOUT_Y + 8 * pixelH;
};