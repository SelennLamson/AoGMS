/// @description

moveCam = keyboard_check(ord("C"));

if(moveCam) {
	x += (keyboard_check(global.keyRight) - keyboard_check(global.keyLeft)) * 6;
	y += (keyboard_check(global.keyDown) - keyboard_check(global.keyUp)) * 6;
} else {
	x = clamp(x, following.x - hBorder, following.x + hBorder);
	y = clamp(y, following.y - vBorder, following.y + vBorder);
}