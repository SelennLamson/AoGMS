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
var interLowLayer = global.floorCollisions[? (depth + 40)];
var interHighLayer = global.floorCollisions[? (depth + 30)];
var newDepth = depth;

// Revert vertical move temporary
y -= _dy;

// Calculate tile related coordinates of edge of player's BBox
var tRight = (x + _right) >> TILE_SHIFT;
var tLeft = (x - _left) >> TILE_SHIFT;
var tBottom = (y + _bottom) >> TILE_SHIFT;
var tTop = (y - _top) >> TILE_SHIFT;
var tX = (x + 0.5 * _right - 0.5 * _left) >> TILE_SHIFT;
var tY = (y + 0.5 * _bottom - 0.5 * _top) >> TILE_SHIFT;

var tileRT = tilemap_get(floorLayer, tRight, tTop) & tile_index_mask;
var tileRB = tilemap_get(floorLayer, tRight, tBottom) & tile_index_mask;
var tileLT = tilemap_get(floorLayer, tLeft, tTop) & tile_index_mask;
var tileLB = tilemap_get(floorLayer, tLeft, tBottom) & tile_index_mask;
var oTileRT = 0;
var oTileRB = 0;
var oTileLT = 0;
var oTileLB = 0;

var tileCenter = tilemap_get(floorLayer, tX, tY) & tile_index_mask;
if (tileCenter >= 78 && tileCenter <= 81) {
	show_debug_message("Stairs detected");
	if (ds_map_exists(global.floorCollisions, depth + global.playerDepthDelta - 100)) {
		show_debug_message("High ground checking !");
		var highGround = global.floorCollisions[? (depth + global.playerDepthDelta - 100)];
		oTileRT = tilemap_get(highGround, tRight, tTop) & tile_index_mask;
		oTileRB = tilemap_get(highGround, tRight, tBottom) & tile_index_mask;
		oTileLT = tilemap_get(highGround, tLeft, tTop) & tile_index_mask;
		oTileLB = tilemap_get(highGround, tLeft, tBottom) & tile_index_mask;
	}
	if (ds_map_exists(global.floorCollisions, depth + global.playerDepthDelta + 100)) {
		show_debug_message("Low ground checking !");
		var lowGround = global.floorCollisions[? (depth + global.playerDepthDelta + 100)];
		oTileRT = tilemap_get(lowGround, tRight, tTop) & tile_index_mask;
		oTileRB = tilemap_get(lowGround, tRight, tBottom) & tile_index_mask;
		oTileLT = tilemap_get(lowGround, tLeft, tTop) & tile_index_mask;
		oTileLB = tilemap_get(lowGround, tLeft, tBottom) & tile_index_mask;
	}
} else if (tileCenter == 0) {
	if (ds_map_exists(global.floorCollisions, depth + global.playerDepthDelta - 100)) {
		var highGround = global.floorCollisions[? (depth + global.playerDepthDelta - 100)];
		if (tilemap_get(highGround, tX, tY) & tile_index_mask != 0) {
			show_debug_message("High ground teleport !");
			newDepth -= 100;
		}
	}
	if (ds_map_exists(global.floorCollisions, depth + global.playerDepthDelta + 100)) {
		var lowGround = global.floorCollisions[? (depth + global.playerDepthDelta + 100)];
		if (tilemap_get(lowGround, tX, tY) & tile_index_mask != 0) {
			show_debug_message("Low ground teleport !");
			newDepth += 100;
		}
	}
}

tileRT = tileRT | oTileRT;
tileRB = tileRB | oTileRB;
tileLT = tileLT | oTileLT;
tileLB = tileLB | oTileLB;

if (_dx > 0 && (tileRT == 0 || tileRB == 0)) {
	x = (tRight << TILE_SHIFT) - _right - 1;
}

if (_dx < 0 && (tileLT == 0 || tileLB == 0)) {
	x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
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

tileRT = tileRT | oTileRT;
tileRB = tileRB | oTileRB;
tileLT = tileLT | oTileLT;
tileLB = tileLB | oTileLB;

if (_dy > 0 && (tileLB == 0 || tileRB == 0)) {
	y = (tBottom << TILE_SHIFT) - _bottom - 1;
}

if (_dy < 0 && (tileLT == 0 || tileRT == 0)) {
	y = (tTop << TILE_SHIFT) + TILE_SIZE + _top;
}

if (depth != newDepth) {
	show_debug_message(string(newDepth));
	layer_element_move(id, layer_get_id_at_depth(newDepth));
}