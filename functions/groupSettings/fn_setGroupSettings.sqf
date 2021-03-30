/*  Sets group names and radio channels
*
*/

#include "component.hpp"

if (!isServer) exitWith {};

private _allgroups = [] call GRAD_groupsettings_fnc_findPlayableGroups;
[_allGroups] call GRAD_groupsettings_fnc_setDynamicGroupNames;
"groupsettings: groups registered" remoteExec ["systemChat",0,false];