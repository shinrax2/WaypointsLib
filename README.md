# WaypointsLib
 modding libary for Raid:WW2 to create custom waypoints

# Waypoint settings:
| parameter | type | description |
|-----------|:----:|:------------|
|unit:|(unit)|A game unit to tie the waypoint to. If the unit is deleted from the game, the waypoint will be removed. Preference as follows: unit head position, unit interaction positions, unit position|
|position:|(vector)|A fixed 3D vector position to place the waypoint at|
|offset:|(vector)|Offset vector from the Unit/position|
|visible_through_walls:|(boolean)|Option to show/hide Waypoints, if the unit is not visible from the players position.|
|mask:|(various)|Slot mask for the visible_through_walls raycast. Can be a default slot_mask name string or a slotmask directly.|
|show_offscreen:|(boolean)|Show this waypoint if it's outside your FOV (default: false)|
|radius_offscreen:|(number)|Radius of the circle the waypoint is orbiting on while moving (default: 200)|
|transition_duration:|(number)|Duration of the animation when a waypoint changes its state between on- and off-screen. (default: 0.3)|
|scale:|(number)|Size scale of the waypoint (default 1)|
|color:|(color)|Default color for all waypoint components. (default: white)|
|alpha:|(number)|Default alpha value of the waypoint (default 1)|
|hide_on_uninteractable:|(boolean)|Flag to determine whether a waypoint should be hidden if the associated unit has an interaction and the interaction is currently blocked (e.g. hide a crowbar waypoint if you already have a crowbar)|
|visible_angle:|(table)	"min"/"max" (number)|values for viewing angle for which the waypoint should be visible|
|visible_distance:|(table) "min"/"max" (number)|values for a distance range for which the waypoint should be visible|
|fade_angle:|(table)| angles and final alpha values for waypoint fading based on viewing angle|
||"min"/"max" (number)|minimum and maximum angle|
||"final_scale"	(number)| alpha to reach on maximum angle| 
|rescale_distance:|(table) "min"/"max" (number)|distance and final scale values for waypoint rescaling based on distance|
||"final_scale"|(number)|multiplier to reach on maximum distance|
|fade_duration:|(table) "min"/"max" (number)|values to start fade (0-1)|
||"alpha"|(boolean)|for it to affect alpha of the whole waypoint|
||"color"|(table)||
||"start"/"stop"|(color)|Color for the whole waypoint on 0/100% progress. (Component color settings have higher priority)|
||"position"|(vector)|to change the position offset of the whole waypoint|
|component_order:|(table) row tables (table)Row definition of components (top-2-bottom).|
|column tables|(table)|Column definition of coponents by names (left-2-right).|

# Component settings:
## (table)		Component definition as subtable of the Waypoint settings. the key will be that components name.
| parameter | type | description |
|-----------|:----:|:------------|
|type:|(string)|Determines the component type (label/icon/distance/timer/duration)|
|show:|(boolean)|Determines whether the component should be shown at all|
|show_offscreen:|(boolean)|Show this waypoint if it's outside your FOV. (default: true, only active if waypoint is visible too)|
|scale:|(number)|Size scale of the waypoint component, gets multiplied on default scale. (default 1)|
|color:|(color)|The color for that components. If not set, it will use the waypoints default color.|
|alpha:|(number)|The alpha value of that component. If not set, it will use the waypoints default alpha.|
|font:|(string)|Font for that component. Icons excluded, for obvious reasons.|
|visible_angle:|(table)|"min"/"max" (number) values for viewing angle for which the waypoint should be visible|
|visible_distance:|(table)|"min"/"max" (number)	values for a distance range for which the waypoint should be visible|
|fade_angle:|(table)|"min"/"max" (number) angles and final alpha values for waypoint fading based on viewing angle
||"final_scale"	(number)|alpha to reach on maximum angle|
|rescale_distance:|(table)|"min"/"max"	(number) distance and final scale values for waypoint rescaling based on distance|
||"final_scale"|(number)|multiplier to reach on maximum distance|
|fade_duration:|(table)|"min"/"max" (number) values to start fade (0-1)|
||"alpha" (boolean)|for it to affect the components alpha|
||"color" (table)| "start"/"stop" (color) Color for the Component on 0/100% progress.|

# Icon exclusive settings:
| parameter | type | description |
|-----------|:----:|:------------|
|texture:|(string)|Path to texture to use for icon|
|texture_rect:|(table)|	Bounding box to use for the icon texture. Containing {x, y, w, h}|
|radial_image|(boolean)|Handle the Image as Radial Image (Red value of color determines how much of an angle of the image is visible)|
|blend_mode|(string)|Determines the image blend mode, e.g. "normal", "add", "sub" (default: "add")|
|std_wp:|(string)|As an alternative to texture/texture_rect, an ID to one of the predefined waypoint icons in the game tweak data (e.g. "wp_crowbar")|

# Label exclusive settings:
| parameter | type | description |
|-----------|:----:|:------------|
|text:|(string)|Label text|

# Timer exclusive settings:
| parameter | type | description |
|-----------|:----:|:------------|
|initial_value:|(number)|Start value of the component (e.g. 30 for a waypoint duration of 30 seconds)|
|auto_update:|(-1/1)|Determines whether timer should be updated internally by the script itself (and in the direction indicated by the sign), or manually updated|
|pause:|(number)|Time the timer gets paused until it starts counting. Only working if auto_update is set.|

# Duration exclusive settings:
| parameter | type | description |
|-----------|:----:|:------------|
|initial_value:|(number)|Start value of the component (e.g. 30 for a waypoint duration of 30 seconds)|

# Last Note: Don't call any functions starting with "_" (or the update-functions) from the outside. Thanks!
