
show_debug_message("SetDoorState");

if (argument0) {
	show_debug_message("DoorOpened");
	id.state = true;
	global.states[? id] = id.state;
	sprite_index = animOpened;
} else {
	show_debug_message("DoorClosed");
	id.state = false;
	global.states[? id] = id.state;
	sprite_index = animClosed;
}