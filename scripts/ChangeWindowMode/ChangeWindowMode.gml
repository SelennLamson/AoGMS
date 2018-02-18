var ds_grid = menuPages[page]

switch (ds_grid[# 3, menuOption[page]]) {
	case 0 : 
		window_set_fullscreen(false);
		global.fullscreen = false;
	break;
	case 1 :
		window_set_fullscreen(true);
		global.fullscreen = true;
	break;
}