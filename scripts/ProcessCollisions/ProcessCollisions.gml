/// @description Do collision testing and solving
//  ProcessCollision(_inst, _dx,_dy, _left,_right, _top,_bottom)
#macro TILE_SIZE	16		// size of debug tilemap
#macro TILE_SHIFT   4		// 1<<5 = 32

var _dx = argument0;
var _dy = argument1;
var _right = argument2;
var _left = argument3;
var _top = argument4;
var _bottom = argument5;
	
// TODO : Process special collisions before tile collisions
// ----------------- SPECIAL COLLISIONS ----------------
	
// ------------------ TILE COLLISIONS ------------------
// Get floor tilemap layer that corresponds to player's depth
var floorLayer = global.floorCollisions[? (depth + global.playerDepthDelta)];

// Revert vertical move temporary
y -= _dy;

// Calculate tile related coordinates of edge of player's BBox
var tRight = (x + _right) >> TILE_SHIFT;
var tLeft = (x - _left) >> TILE_SHIFT;
var tBottom = (y + _bottom) >> TILE_SHIFT;
var tTop = (y - _top) >> TILE_SHIFT;

var tileRT = tilemap_get(floorLayer, tRight, tTop) & tile_index_mask;
var tileRB = tilemap_get(floorLayer, tRight, tBottom) & tile_index_mask;
var tileLT = tilemap_get(floorLayer, tLeft, tTop) & tile_index_mask;
var tileLB = tilemap_get(floorLayer, tLeft, tBottom) & tile_index_mask;

if (_dx > 0 && (tileRT == 0 || tileRB == 0)) {
	x = (tRight << TILE_SHIFT) - _right - 1;
}

if (_dx < 0 && (tileLT == 0 || tileLB == 0)) {
	x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left + 1;
}

// Redo vertical move
y += _dy;

// Recalculate after move
tRight = (x + _right) >> TILE_SHIFT;
tLeft = (x - _left) >> TILE_SHIFT;
tBottom = (y + _bottom) >> TILE_SHIFT;
tTop = (y - _top) >> TILE_SHIFT;

tileRT = tilemap_get(floorLayer, tRight, tTop) & tile_index_mask;
tileRB = tilemap_get(floorLayer, tRight, tBottom) & tile_index_mask;
tileLT = tilemap_get(floorLayer, tLeft, tTop) & tile_index_mask;
tileLB = tilemap_get(floorLayer, tLeft, tBottom) & tile_index_mask;

if (_dy > 0 && (tileLB == 0 || tileRB == 0)) {
	y = (tBottom << TILE_SHIFT) - _bottom - 1;
}

if (_dy < 0 && (tileLT == 0 || tileRT == 0)) {
	y = (tTop << TILE_SHIFT) + TILE_SIZE + _top + 1;
}