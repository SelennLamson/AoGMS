/// @description Do collision testing and solving
//  ProcessCollision(_inst, _dx,_dy, _left,_right, _top,_bottom)
#macro TILE_SIZE	16		// size of debug tilemap
#macro TILE_SHIFT   4		// 1<<5 = 32

var _inst = argument0;
var _dx = argument1;
var _dy = argument2;
var _right = argument3;
var _left = argument4;
var _top = argument5;
var _bottom = argument6;

with (_inst) {
	// Do move, regardless of collisions
	x += walkSpeed * cos(walkDirection);
	y += walkSpeed * sin(walkDirection);
	
	// TODO : Process special collisions before tile collisions
	// ----------------- SPECIAL COLLISIONS ----------------
	
	// ------------------ TILE COLLISIONS ------------------
	// Get floor tilemap layer that corresponds to player's depth
	var floorLayer = global.floorCollisions[? depth + global.playerDepthDelta];
	var collidedTiles = ds_list_create();
	
	// Calculate tile related coordinates of edge of player's BBox
	var tRight = (x + _right) >> TILE_SHIFT;
	var tLeft = (x - _left) >> TILE_SHIFT;
	var tBottom = (y + _bottom) >> TILE_SHIFT;
	var tTop = (y - _top) >> TILE_SHIFT;
	
	// Get the tile at each corner of player's BBox, update position if collision detected
	if (tilemap_get(floorLayer, tRight, tBottom) & tile_index_mask == 0) {
		x = (tRight << TILE_SHIFT) - _right;
		y = (tBottom << TILE_SHIFT) - _bottom - 1;
	}
	
	if (tilemap_get(floorLayer, tRight, tTop) & tile_index_mask == 0) {
		x = (tRight << TILE_SHIFT) - _right;
		y = (tTop << TILE_SHIFT) + TILE_SIZE + _top + 1;
	}
	
	if (tilemap_get(floorLayer, tLeft, tBottom) & tile_index_mask == 0) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		y = (tBottom << TILE_SHIFT) - _bottom - 1;
	}
	
	if (tilemap_get(floorLayer, tLeft, tTop) & tile_index_mask == 0) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		y = (tTop << TILE_SHIFT) + TILE_SIZE + _top + 1;
	}
}
