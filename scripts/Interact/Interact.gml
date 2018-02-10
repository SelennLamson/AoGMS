show_debug_message("Interaction received");

// --------------DOORS--------------

if (object_get_parent(object_index) == obj_doorsParents) {
	show_debug_message("Parent Found");
	SetDoorState(conditions);
}