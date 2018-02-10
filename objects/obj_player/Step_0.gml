///@description

var ox = x;
var oy = y;

MovePlayer();

ProcessCollisions(x - ox, y - oy, 5, 5, -5, 15);
// BBox defined by the last 4 arguments : right, left, top, bottom

// ---------------INTERACT---------------

// GAMEPAD & KEYBOARD

if (gamepad_button_check_pressed(0, gInputs[0]) || keyboard_check_pressed(kInputs[5])) {	// Interact button or key
	var instID = instance_nearest(xNearest, yNearest, obj_interactables);	// Returns real
	show_debug_message("INSTANCE ID")
	show_debug_message(instID);
	with (instID) {
		if (interactable) { // == true
			Interact();
		}
	}
}

// TEST PERSISTROOM

if keyboard_check_pressed(ord("R")) {
	show_debug_message(room_get_name(room));
	room_goto(PersistTest);
}

if keyboard_check_pressed(ord("T")) {
	show_debug_message(room_get_name(room));
	room_goto(Test);
}