///@description Move the player based on the various different controllers

// --------------------GAMEPAD--------------------
gamepad_set_axis_deadzone(0, 0.5);
gamepad_set_button_threshold(0, 0.1);

var xaxis = gamepad_axis_value(0, gp_axislh);
var yaxis = gamepad_axis_value(0, gp_axislv);

if ((hspeed != 0) || (vspeed != 0)) {
	x += xaxis * walkSpeed;
	y += yaxis * walkSpeed;
}


// --------------------KEYBOARD-------------------

// --------------------SPRITES--------------------

animUp[0] = spr_player_idle_up;
animUp[1] = spr_player_up;

animDown[0] = spr_player_idle_down;
animDown[1] = spr_player_down;

animLeft[0] = spr_player_idle_left;
animLeft[1] = spr_player_left;

animRight[0] = spr_player_idle_right;
animRight[1] = spr_player_right;

// --------------------DIRECTIONS-----------------

