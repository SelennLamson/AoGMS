/// @description Room initialization

global.floorCollisions = ds_map_create();

var layers = layer_get_all();
for (var i = 0; i < array_length_1d(layers); i++) {
	if (string_count("Floor", layer_get_name(layers[i]))) {
		ds_map_add(global.floorCollisions, layer_get_depth(layers[i]), layers[i]);
	}
}
