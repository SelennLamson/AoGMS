var map = argument0;
var mask = argument1;
var xx = argument2;
var yy = argument3;

return (tilemap_get(map, xx, yy) & mask) == mask;