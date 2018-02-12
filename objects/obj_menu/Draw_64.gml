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

draw_set_halign(fa_left);

var rtx = startX + xBuffer, rty;

yy = 0;

repeat (ds_height) {
	rty = startY + (yy * yBuffer);
	switch(ds_grid[# 1, yy]) {
		case menuElementType.shift :
			var currentVal = ds_grid[# 3, yy];
			var currentArray = ds_grid[# 4, yy];
			var leftShift = "<< ";
			var rightShift = " >>";
			
			if (currentVal == 0) {
				leftShift = "";
			}
			if (currentVal == array_length_1d(ds_grid[# 4, yy]) - 1) {
				rightShift = "";	
			}
			
			c = c_white;
			
			draw_text_color(rtx, rty, leftShift + currentArray[currentVal] + rightShift, c, c, c, c, 1);
		break;
		
		case menuElementType.slider :
			var len = 64;
			var currentVal = ds_grid[# 3, yy];
			var currentArray = ds_grid[# 4, yy];
			var circlePos = ((currentVal - currentArray[0]) / (currentArray[1] - currentArray[0]));
			c = c_white;
			
			draw_line_width(rtx, rty, rtx + len, rty, 2);
			draw_circle_color(rtx + (circlePos * len), rty, 4, c, c, false);
			draw_text_color(rtx + (len * 1.2), rty, string(floor(circlePos * 100)) + "%", c, c, c, c, 1);
		break;
		
		case menuElementType.toggle :
			var currentVal = ds_grid[# 3, yy];
			var c1, c2;
			c = c_white;

			if (currentVal == 0) {
				c1 = c;
				c2 = c_dkgray;
			} else {
				c1 = c_dkgray;
				c2 = c;
			}
			
			draw_text_color(rtx, rty, "ON", c1, c1, c1, c1, 1);
			draw_text_color(rtx + 32, rty, "OFF", c2, c2, c2, c2, 1);
		break;
		
		case menuElementType.input :
			var currentVal = ds_grid[# 3, yy];
			var stringVal;
			
			if (currentVal) {
				// Display the current input for keys
			}
		break;
	}
	yy++;
}

draw_set_valign(fa_top);