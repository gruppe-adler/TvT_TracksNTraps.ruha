#include "component.hpp"
#define PLAYABLE_UNITS (playableUnits + switchableUnits)

private _blugroups = [];
private _opfgroups = [];
private _indgroups = [];
private _civgroups = [];

{
    if ((leader _x) in PLAYABLE_UNITS) then {
        switch (side _x) do {
            case west: {_blugroups pushBack _x};
            case east: {_opfgroups pushBack _x};
            case independent: {_indgroups pushBack _x};
            case civilian: {_civgroups pushBack _x};
            default {WARNING(format["Could not find side of group: %1", _x])};
        };
    };
} forEach allGroups;

[_blugroups,_opfgroups,_indgroups, _civgroups]
