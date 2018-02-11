if(!global.pause) exit;

var gWidth = global.viewWidth, gHeight = global.viewHeight;

var ds_grid = menuPages[page], ds_height = ds_grid_height(ds_grid);
var yBuffer = 32, xBuffer = 16;
var startY = (gHeight/2) - ((((ds_height - 1) / 2) * yBuffer));
var startX = gWidth / 2;

// Draw Pause Menu "Back"

var c = c_black;
draw_rectangle_color(0, 0, gWidth, gHeight, c, c, c, c, false);

// Draw Elements on Left Side

draw_set_valign(fa_middle);
draw_set_halign(fa_right);

var ltx = startX - xBuffer, lty, xo;

var yy = 0;

repeat(ds_height) {
	lty = startY + (yy * yBuffer);
	c = c_white;
	xo = 0;
	
	if (yy == menuOption[page]) {
		c = c_orange;
		xo = -(xBuffer / 2);
	}
	
	draw_text_color(ltx + xo, lty, ds_grid[# 0, yy], c, c, c, c, 1);
	yy++;
}

// Draw Dividing Line

draw_line(startX, startY, startX, lty);


// Draw Elements on Right Side