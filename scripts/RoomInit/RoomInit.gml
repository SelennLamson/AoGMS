// -------------LOADED ROOMS-----------
// Checks if the room has been saved in the ds_list loadedRooms

var roomName = room_get_name(room);

if (ds_list_find_index(global.loadedRooms, roomName) == -1) { // The room has never been loaded
	for (var i = 0; i < instance_count; i++)
		with (instance_id[i])
			if (variable_instance_exists(id, "state"))
				global.states[? id] = state;
	
	ds_list_add(global.loadedRooms, roomName);
	
} else {	// The room is already in loadedRooms
	for (var i = 0; i < instance_count; i++)
		with (instance_id[i])
			if (ds_map_exists(global.states, id)) {
				state = global.states[? id];
				event_user(1);
			}
}

ComputeRoomStates();

// -------------COLLISIONS-------------

ds_map_clear(global.floorCollisions);

var layers = layer_get_all();

for (var i = 0; i < array_length_1d(layers); i++)
	if (string_count("Floor", layer_get_name(layers[i])))
		CreateCollideMap(layers[i]);
