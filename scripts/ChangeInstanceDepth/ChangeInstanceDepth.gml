var yPlayer = argument0;

var currentLayerName = layer_get_name(layer);

if (y < yPlayer && string_count("InstancesUp", currentLayerName)) {
	currentLayerName = string_replace(currentLayerName, "Up", "Down");
	layer = layer_get_id(currentLayerName);
} else if (y > yPlayer && string_count("InstancesDown", currentLayerName)) {
	currentLayerName = string_replace(currentLayerName, "Down", "Up");
	layer = layer_get_id(currentLayerName);
}