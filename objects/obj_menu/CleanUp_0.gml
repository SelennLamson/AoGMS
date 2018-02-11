var i = 0, array_len = array_length_1d(menuPages);
repeat (array_len) {
	ds_grid_destroy(menuPages[i]);
	i++;
}