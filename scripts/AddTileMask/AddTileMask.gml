var map = argument0;
var mask = argument1;
var xx = argument2;
var yy = argument3;

tilemap_set(map, tilemap_get(map, xx, yy) | mask, xx, yy);