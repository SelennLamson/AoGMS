/// @description Game initialization

global.floorCollisions = ds_map_create();
global.playerDepthDelta = 50;

global.states = ds_map_create();
global.loadedRooms = ds_list_create();

room_goto(room_next(room));
