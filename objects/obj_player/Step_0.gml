///@description

var ox = x;
var oy = y;

MovePlayer();

ProcessCollisions(x - ox, y - oy, 4, 5, -6, 15);
// BBox defined by the last 4 arguments : right, left, top, bottom

// ---------------INTERACT---------------

// GAMEPAD & KEYBOARD

if (gamepad_button_check_pressed(0, global.gpInteract) || keyboard_check_pressed(global.keyInteract)) {	// Interact button or key
	var xPlayer = x;
	var yPlayer = y;
	var radius = interactionRadius;
	with (obj_interactable)
		if (abs(xPlayer - x) <= radius && abs(yPlayer - y) <= radius)
			if (interactable && (interactAgain || (state != stateWhenTrue))) {
				ComputeState();
				break;
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