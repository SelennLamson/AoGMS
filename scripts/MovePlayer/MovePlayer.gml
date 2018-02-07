///@description Move the player based on the various different controllers

// --------------------GAMEPAD--------------------

var xaxis = gamepad_axis_value(0, gp_axislh);
var yaxis = gamepad_axis_value(0, gp_axislv);

// MOVE

if ((xaxis != 0) || (yaxis != 0)) {
	x += xaxis * walkSpeed;
	y += yaxis * walkSpeed;
}

// --------------------KEYBOARD-------------------

//var moveXinput = 0;
//var moveYinput = 0;

//for (var i = 0; i < array_length_1d(movementInputs); i++) {
//	var thisKey = movementInputs[i];
//	if keyboard_check(thisKey) {
//		var thisAngle = i*90;
//		moveXinput += lengthdir_x(1, thisAngle);
//		moveYinput += lengthdir_y(1, thisAngle);
//	}
//}

// CURRENT ANIMATION

if (xaxis > 0) {
	currentAnim = animRight;
}
if (xaxis < 0) {
	currentAnim = animLeft;
}
if (yaxis > 0) {
	currentAnim = animDown;
}
if (yaxis < 0) {
	currentAnim = animUp;
}

if ((xaxis == 0) && (yaxis == 0)) {
	sprite_index = currentAnim[0];
} else {
	sprite_index = currentAnim[1];
}
