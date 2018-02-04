/// @description MOVE


if (keyboard_check(vk_shift)) {
	walkSpeed = 3;
}

// MOVEMENT
if(keyboard_check(ord("D"))) {
	x += walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_right;
}
if(keyboard_check(ord("Q"))) {
	x -= walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_left;
}
if(keyboard_check(ord("S"))) {
	y += walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_down;
}
if(keyboard_check(ord("Z"))) {
	y -= walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_up;
}

// SPRINT


/*if(keyboard_check(ord("D"))) && keyboard_check(vk_shift) {
	walkSpeed = 2;
	x += walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_right;
}
if(keyboard_check(ord("Q"))) && keyboard_check(vk_shift) {
	walkSpeed = 2;
	x -= walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_left;
}
if(keyboard_check(ord("S"))) && keyboard_check(vk_shift) {
	walkSpeed = 2;
	y += walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_down;
}
if(keyboard_check(ord("Z"))) && keyboard_check(vk_shift) {
	walkSpeed = 2;
	y -= walkSpeed;
	image_speed = walkSpeed / 3;
	sprite_index = spr_player_up;
}*/

	// Sprint & end movement
	
	if(keyboard_check_released(ord("D"))) {
		keyboard_key_release(vk_shift);
	}
	if(keyboard_check_released(ord("Q"))) {
		keyboard_key_release(vk_shift);
	}
	if(keyboard_check_released(ord("S"))) {
		keyboard_key_release(vk_shift);
	}
	if(keyboard_check_released(ord("Z"))) {
		keyboard_key_release(vk_shift);
	}

// END MOVEMENT

if(keyboard_check(vk_nokey)) {
	image_speed	= 0;
	walkSpeed = 1.5;

	if(sprite_index = spr_player_right) {
		sprite_index = spr_player_idle_right;
	}
	if(sprite_index = spr_player_left) {
		sprite_index = spr_player_idle_left;
	}
	if(sprite_index = spr_player_down) {
		sprite_index = spr_player_idle_down;
	}
	if(sprite_index = spr_player_up) {
		sprite_index = spr_player_idle_up;
	}
}