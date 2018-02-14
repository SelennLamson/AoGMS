///@description Move the player based on the various different controllers

var moveSpeed = walkSpeed;

// --------------------GAMEPAD--------------------

var xaxis = gamepad_axis_value(0, gp_axislh);
var yaxis = gamepad_axis_value(0, gp_axislv);

// --------------------KEYBOARD-------------------

if (keyboard_check(global.keyUp)) {
	yaxis = -1;
}
if (keyboard_check(global.keyDown)) {
	yaxis = 1;
	
}
if (keyboard_check(global.keyLeft)) {
	xaxis = -1;
}
if (keyboard_check(global.keyRight)) {
	xaxis = 1;
}

// --------------------SPRINT---------------------

// GAMEPAD

if (gamepad_button_check(0, global.keySprint)) {
	moveSpeed = sprintSpeed;
}

// KEYBOARD

if (keyboard_check(global.gpSprint)) {
	moveSpeed = sprintSpeed;
}

// --------------------MOVE-----------------------

if ((xaxis != 0) || (yaxis != 0)) {
	x += xaxis * moveSpeed;
	y += yaxis * moveSpeed;
}

// --------------------CURRENT ANIMATION----------

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