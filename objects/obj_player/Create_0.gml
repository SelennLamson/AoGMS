// -------------------COLLISIONS------------------

depthDelta = global.playerDepthDelta;

// --------------------SPRITES--------------------

animUp[0] = spr_player_idle_up;
animUp[1] = spr_player_up;

animDown[0] = spr_player_idle_down;
animDown[1] = spr_player_down;

animLeft[0] = spr_player_idle_left;
animLeft[1] = spr_player_left;

animRight[0] = spr_player_idle_right;
animRight[1] = spr_player_right;

currentAnim = animDown;

// --------------------GAMEPAD--------------------

gamepad_set_axis_deadzone(0, 0.4);
gamepad_set_button_threshold(0, 0.1);

// NORMAL MODE

gInputs[0] = gp_face1;		// A
gInputs[1] = gp_face2;		// B
gInputs[2] = gp_face3;		// X
gInputs[3] = gp_face4;		// Y

gInputs[5] = gp_shoulderl;	// LB
gInputs[6] = gp_shoulderlb;	// LT	SPRINT
gInputs[7] = gp_shoulderr;	// RB
gInputs[8] = gp_shoulderrb;	// RT

gInputs[9] = gp_select;		// Select
gInputs[10] = gp_start;		// Start	MENU

gInputs[11] = gp_stickl;	// Left stick pressed as a button
gInputs[12] = gp_stickr;	// Right stick pressed as a button

gInputs[13] = gp_padu;		// D-pad up
gInputs[14] = gp_padd;		// D-pad down
gInputs[15] = gp_padl;		// D-pad left
gInputs[16] = gp_padr;		// D-pad right

// PREY MODE


// --------------------KEYBOARD-------------------

// NORMAL MODE

kInputs[0] = ord("Z");	// MOVE UP
kInputs[1] = ord("S");	// MOVE DOWN
kInputs[2] = ord("Q");	// MOVE LEFT
kInputs[3] = ord("D");	// MOVE RIGHT
kInputs[4] = vk_shift;	// SPRINT

// PREY MODE