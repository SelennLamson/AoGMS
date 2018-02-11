if (!global.pause) exit;

inputUp		= keyboard_check_pressed(vk_up);
inputDown	= keyboard_check_pressed(vk_down);
inputEnter	= keyboard_check_pressed(vk_enter);

var ds_grid = menuPages[page], ds_height = ds_grid_height(ds_grid);

var ochange = inputDown - inputUp;

if (ochange != 0) {
	menuOption[page] += ochange;
	if (menuOption[page] > ds_height - 1) {
		menuOption[page] = 0;
	}
	if (menuOption[page] < 0) {
		menuOption[page] = ds_height - 1;
	}
}