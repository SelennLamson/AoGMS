/// @description Do collision testing and solving
//  ProcessCollision(_inst, _dX,_dY, _left,_right, _top,_bottom)
#macro TILE_SIZE	16		// size of debug tilemap
#macro TILE_SHIFT   4		// 1<<5 = 32

var _dX = argument0;
var _dY = argument1;
var _right = argument2;
var _left = argument3;
var _top = argument4;
var _bottom = argument5;
	
// TODO : Process special collisions before tile collisions
// ----------------- SPECIAL COLLISIONS ----------------
	
// ------------------ TILE COLLISIONS ------------------
// Get collision tilemap that corresponds to player's depth
var collLayer = global.floorCollisions[? (depth + global.playerDepthDelta)];

var oy = y - _dY;

var xC = x - _dX + 0.5 * _right - 0.5 * _left;
var yC = y - _dY + 0.5 * _bottom - 0.5 * _top;

var tX = xC >> TILE_SHIFT;
var tY = yC >> TILE_SHIFT;

var dYR = xC - (tX << TILE_SHIFT);
var dYL = TILE_SIZE - dYR;

var tYR = (yC + dYR) >> TILE_SHIFT;
var tYL = (yC + dYL) >> TILE_SHIFT;

if (TileHasMask(collLayer, global.mask_stairsLeft, tX, tYL)) {
	if (_dX != 0) {
		y -= _dY;
		y += _dX;
		_dY = _dX;
	}
	tY = tYL;
} else if (TileHasMask(collLayer, global.mask_stairsRight, tX, tYR)) {
	if (_dX != 0) {
		y -= _dY;
		y -= _dX;
		_dY = -_dX;
	}
	tY = tYR;
}

var xRight = x + _right;
var xLeft = x - _left;
var yTop = y - _top;
var yBottom = y + _bottom;

var tRight = xRight >> TILE_SHIFT;
var tLeft = xLeft >> TILE_SHIFT;
var tTopL = yTop >> TILE_SHIFT;
var tTopR = tTopL;
var tBottomL = yBottom >> TILE_SHIFT;
var tBottomR = tBottomL;

var tTRR = (yTop + dYR) >> TILE_SHIFT;
var tTLR = tTRR;
var tBRR = (yBottom + dYR) >> TILE_SHIFT;
var tBLR = tBRR;
var tTRL = (yTop + dYL) >> TILE_SHIFT;
var tTLL = tTRL;
var tBRL = (yBottom + dYL) >> TILE_SHIFT;
var tBLL = tBRL;

var dYRR = dYR;
var dYLR = dYR;
var dYRL = dYL;
var dYLL = dYL;

if (tLeft != tX) {
	tTLR++;
	tBLR++;
	tTLL--;
	tBLL--;
	dYLR += TILE_SIZE;
	dYLL -= TILE_SIZE;
	if (_dY == 0 && tTLR != tBLR)
		tBLR = tTLR;
}
if (tRight != tX) {
	tTRR--;
	tBRR--;
	tTRL++;
	tBRL++;
	dYRR -= TILE_SIZE;
	dYRL += TILE_SIZE;
	if (_dY == 0 && tTRL != tBRL)
		tBRL = tTRL;
}

var dR = 0;
var dL = 0;
if (TileHasMask(collLayer, global.mask_stairsRight, tRight, tTRR) ||
	TileHasMask(collLayer, global.mask_stairsRight, tRight, tBRR)) {
	tTopR = tTRR;
	tBottomR = tBRR;
	dR = dYRR;
}
if (TileHasMask(collLayer, global.mask_stairsRight, tLeft, tTLR) ||
	TileHasMask(collLayer, global.mask_stairsRight, tLeft, tBLR)) {
	tTopL = tTLR;
	tBottomL = tBLR;
	dL = dYLR;
}
if (TileHasMask(collLayer, global.mask_stairsLeft, tRight, tTRL) ||
	TileHasMask(collLayer, global.mask_stairsLeft, tRight, tBRL)) {
	tTopR = tTRL;
	tBottomR = tBRL;
	dR = dYRL;
}
if (TileHasMask(collLayer, global.mask_stairsLeft, tLeft, tTLL) ||
	TileHasMask(collLayer, global.mask_stairsLeft, tLeft, tBLL)) {
	tTopL = tTLL;
	tBottomL = tBLL;
	dL = dYLL;
}

if (_dX >= 0 && _dY > 0) {				// ------------------------------------------------ RIGHT ; DOWN
	if (ShouldCollide(collLayer, 1, tRight, tTopR, tX, tY)) {
		x = (tRight << TILE_SHIFT) - _right - 1;
		
		if (ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY))
			y = (tBottomL << TILE_SHIFT) - _bottom - 1 - dL;
	} else if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY))
		y = (tBottomR << TILE_SHIFT) - _bottom - 1 - dR;
	else if (ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY))
		y = (tBottomL << TILE_SHIFT) - _bottom - 1 - dL;
		
} else if (_dX >= 0) {					// ------------------------------------------------ RIGHT ; UP
	if (ShouldCollide(collLayer, 1, tRight, tBottomR, tX, tY)) {
		x = (tRight << TILE_SHIFT) - _right - 1;
		
		if (ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY))
			y = (tTopL << TILE_SHIFT) + TILE_SIZE + _top - dL;
	} else if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY))
		y = (tTopR << TILE_SHIFT) + TILE_SIZE + _top - dR;
	else if (ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY))
		y = (tTopR << TILE_SHIFT) + TILE_SIZE + _top - dL;
	
} else if (_dX < 0 && _dY > 0) {		// ------------------------------------------------ LEFT ; DOWN
	if (ShouldCollide(collLayer, 3, tLeft, tTopL, tX, tY)) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		
		if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY))
			y = (tBottomR << TILE_SHIFT) - _bottom - 1 - dR;
	} else if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY))
		y = (tBottomR << TILE_SHIFT) - _bottom - 1 - dR;
	else if (ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY))
		y = (tBottomL << TILE_SHIFT) - _bottom - 1 - dL;
		
} else if (_dX < 0) {					// ------------------------------------------------ LEFT ; UP
	if (ShouldCollide(collLayer, 3, tLeft, tBottomL, tX, tY)) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		
		if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY))
			y = (tTopR << TILE_SHIFT) + TILE_SIZE + _top - dR;
	} else if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY))
		y = (tTopR << TILE_SHIFT) + TILE_SIZE + _top - dR;
	else if (ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY))
		y = (tTopL << TILE_SHIFT) + TILE_SIZE + _top - dL;
	
}

tX = (x + 0.5 * _right - 0.5 * _left) >> TILE_SHIFT;
tY = (y + 0.5 * _bottom - 0.5 * _top) >> TILE_SHIFT;

if (TileHasMask(collLayer, global.mask_riseDepth, tX, tY)) {
	depth -= global.layerDelta;
} else if (TileHasMask(collLayer, global.mask_lowerDepth, tX, tY)) {
	depth += global.layerDelta;
}

if (y - oy != 0) {
	var yPlayer = y;
	for (var i = 0; i < instance_count; i++)
		with (instance_id[i])
			if (object_is_ancestor(object_index, obj_physical))
				if (changeDepth)
					ChangeInstanceDepth(yPlayer);
}