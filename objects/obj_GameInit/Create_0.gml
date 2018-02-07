/// @description Game initialization

global.floorCollisions = ds_map_create();
global.playerDepthDelta = 50;

room_goto(room_next(room));
