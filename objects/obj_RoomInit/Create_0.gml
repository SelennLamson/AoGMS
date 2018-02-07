/// @description Room initialization

ds_map_clear(global.floorCollisions);

var layers = layer_get_all();

for (var i = 0; i < array_length_1d(layers); i++) {
	if (string_count("Floor", layer_get_name(layers[i]))) {
		show_debug_message(string(layer_get_depth(layers[i])));
		ds_map_add(global.floorCollisions, layer_get_depth(layers[i]), layer_tilemap_get_id(layers[i]));
	}
}
