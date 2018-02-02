/// @description MOVE

// MOUVEMENT
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

// FIN DU MOUVEMENT

if(keyboard_check(vk_nokey)) {
	image_speed	= 0;
	if(keyboard_check_released(ord("D"))) {
		sprite_index = spr_player_idle_right;
	}
	if(keyboard_check_released(ord("Q"))) {
		sprite_index = spr_player_idle_left;
	}
	if(keyboard_check_released(ord("S"))) {
	sprite_index = spr_player_idle_down;
	}
	if(keyboard_check_released(ord("Z"))) {
		sprite_index = spr_player_idle_up;
	}
}