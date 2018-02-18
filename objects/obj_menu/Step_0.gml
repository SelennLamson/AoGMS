if (!global.menu) exit;

inputUp		= keyboard_check_pressed(vk_up);
inputDown	= keyboard_check_pressed(vk_down);
inputEnter	= keyboard_check_pressed(vk_enter);

var ds_grid = menuPages[page], ds_height = ds_grid_height(ds_grid);

if (inputting) {
	switch(ds_grid[# 1, menuOption[page]]) {
		case menuElementType.shift :
			var hinput = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
			if (hinput != 0) {
				// audio
				ds_grid[# 3, menuOption[page]] += hinput;
				ds_grid[# 3, menuOption[page]] = clamp(ds_grid[# 3, menuOption[page]], 0, array_length_1d(ds_grid[# 4, menuOption[page]]) - 1);
			}
		break;
		
		case menuElementType.slider :
			var hinput = keyboard_check(vk_right) - keyboard_check(vk_left);
				if (hinput != 0) {
					ds_grid[# 3, menuOption[page]] += hinput * 0.01;
					ds_grid[# 3, menuOption[page]] = clamp(ds_grid[# 3, menuOption[page]], 0, 1);
				}
				break;
				
		case menuElementType.toggle :
			var hinput = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
				if (hinput != 0) {
					// audio
					ds_grid[# 3, menuOption[page]] += hinput;
					ds_grid[# 3, menuOption[page]] = clamp(ds_grid[# 3, menuOption[page]], 0, 1);
				}
				break;
				
		case menuElementType.input :
			var kk = keyboard_lastkey;
			if (kk != vk_enter) {
				if (kk != ds_grid[# 3, menuOption[page]]) { }//audio
				ds_grid[# 3, menuOption[page]] = kk;
				variable_global_set(ds_grid[# 2, menuOption[page]], kk);
			}
		
		break;
	}
} else {
	var ochange		= inputDown - inputUp;

	if (ochange != 0) {
		menuOption[page] += ochange;
		if (menuOption[page] > ds_height - 1) {
			menuOption[page] = 0;
		}
		if (menuOption[page] < 0) {
			menuOption[page] = ds_height - 1;
		}
	}
}

if (inputEnter) {
	switch(ds_grid[# 1, menuOption[page]]) {
		case menuElementType.scriptRunner : script_execute(ds_grid[# 2, menuOption[page]]); break;
		case menuElementType.pageTransfer : page = ds_grid[# 2, menuOption[page]]; break;
		case menuElementType.shift :
		case menuElementType.slider :
		case menuElementType.toggle : if(inputting) { script_execute(ds_grid[# 2, menuOption[page]], ds_grid[# 3, menuOption[page]]); }
		case menuElementType.input :
			inputting = !inputting;
		break;
	}
	// add an Audio sound
}