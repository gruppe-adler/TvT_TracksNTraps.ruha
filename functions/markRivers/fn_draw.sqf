/*
 * Name: gradTnT_markRivers_fnc_draw
 * Author: DerZade
 * Event handler for draw event on map controls.
 *
 * Arguments:
 * 1: Map control <CONTROL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * N/A
 *
 * Public: No
 */
params ["_ctrl"];
if (isNil "grad_markRivers_rivers") exitWith {};

grad_markRivers_rivers params ["_waterColor", "_riverTris", "_bridges"];
_ctrl drawTriangle [_riverTris, [1,1,1,1], _waterColor];

{
	_x params ["_tris", "_lines", "_colorFill", "_color"];
	_ctrl drawTriangle [_tris, [1,1,1,1], _colorFill];
	{
		_ctrl drawLine [_x select 0, _x select 1, _color];
	} forEach _lines;
} forEach _bridges;