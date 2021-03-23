// quote given variable
#define QUOTE(var) #var

// convert from 255-color value to arma color value (just for better readability)
#define FROM255(VAL) VAL / 255

// colors (all only red, green, blue)
#define COLOR_PRIMARY FROM255(67), FROM255(140), FROM255(238)
#define COLOR_ACCENT FROM255(84), FROM255(89), FROM255(92)
#define COLOR_BACKGROUND FROM255(38), FROM255(46), FROM255(51)
#define COLOR_WARNING FROM255(161), FROM255(11), FROM255(11)
#define COLOR_TEXT 1, 1, 1
#define COLOR_FIELD_BACKGROUND 0, 0, 0

#define GRID_W (pixelW * pixelGrid)
#define GRID_H (pixelH * pixelGrid)

// EM = default text size
#define EM 5
#define EM_H (EM * GRID_H)
#define EM_W (EM * GRID_W)

// default spacing between fields
#define FIELD_SPACING_H (0.325 * EM_H)
#define FIELD_SPACING_W (0.325 * EM_W)

// background corner radius in pixels
#define BACKGROUND_CORNER_RADIUS 20

// x-pos to center control with given width within screen 
#define CENTER_X(w) (safezoneX + (safezoneW - w) / 2)

// y-pos to center control with given height within screen 
#define CENTER_Y(h) (safezoneY + (safezoneH - h) / 2)

// path to direcotry of this file (without trailing backslash)
#define BASE_PATH ui

// prepend path to assets (pictures)
#define ASSET(path) BASE_PATH\data\path

// quoute version of ASSET()
#define QASSET(path) QUOTE(ASSET(path))
