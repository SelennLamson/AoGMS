/// @description Room initialization

ds_map_clear(global.floorCollisions);

var layers = layer_get_all();

for (var i = 0; i < array_length_1d(layers); i++) {
	if (string_count("Floor", layer_get_name(layers[i]))) {
		CreateCollideMap(layers[i]);
	}
}
