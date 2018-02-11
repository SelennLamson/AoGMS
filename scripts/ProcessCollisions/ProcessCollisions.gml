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

var xC = x - _dX + 0.5 * _right - 0.5 * _left;
var yC = y - _dY + 0.5 * _bottom - 0.5 * _top;

var tX = xC >> TILE_SHIFT;
var tY = yC >> TILE_SHIFT;

var dYCR = xC - (tX << TILE_SHIFT);
var dYCL = (tX << TILE_SHIFT) + TILE_SIZE - xC;

var tYR = (yC + dYCR) >> TILE_SHIFT;
var tYL = (yC + dYCL) >> TILE_SHIFT;

if (TileHasMask(collLayer, global.mask_stairsLeft, tX, tYL)) {
	if (_dY != 0 && _dX != 0) {
		y -= _dY;
		_dY = 0;
	}
	y += _dX;
} else if (TileHasMask(collLayer, global.mask_stairsRight, tX, tYR)) {
	if (_dY != 0 && _dX != 0) {
		y -= _dY;
		_dY = 0;
	}
	y -= _dX;
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

var dYRR = xRight - (tRight << TILE_SHIFT);
var dYLR = xLeft - (tLeft << TILE_SHIFT);
var dYRL = (tRight << TILE_SHIFT) + TILE_SIZE - xRight;
var dYLL = (tLeft << TILE_SHIFT) + TILE_SIZE - xLeft;

var tTRR = (yTop + dYRR) >> TILE_SHIFT;
var tTRL = (yTop - dYRL) >> TILE_SHIFT;
var tBRR = (yBottom + dYRR) >> TILE_SHIFT;
var tBRL = (yBottom - dYRL) >> TILE_SHIFT;
var tTLR = (yTop + dYLR) >> TILE_SHIFT;
var tTLL = (yTop - dYLL) >> TILE_SHIFT;
var tBLR = (yBottom + dYLR) >> TILE_SHIFT;
var tBLL = (yBottom - dYLL) >> TILE_SHIFT;

var dTopR = 0;
var dBottomR = 0;
var dTopL = 0;
var dBottomL = 0;
if (TileHasMask(collLayer, global.mask_stairsRight, tRight, tTRR) ||
	TileHasMask(collLayer, global.mask_stairsRight, tRight, tBRR)) {
	dTopR = tTRR - tTopR;
	tTopR = tTRR;
	dBottomR = tBRR - tBottomR;
	tBottomR = tBRR;
}
if (TileHasMask(collLayer, global.mask_stairsRight, tLeft, tTLR) ||
	TileHasMask(collLayer, global.mask_stairsRight, tLeft, tBLR)) {
	dTopL = tTLR - tTopL;
	tTopL = tTLR;
	dBottomL = tBLR - tBottomL;
	tBottomL = tBLR;
}
if (TileHasMask(collLayer, global.mask_stairsLeft, tRight, tTRL) ||
	TileHasMask(collLayer, global.mask_stairsLeft, tRight, tBRL)) {
	dTopR = tTRL - tTopR;
	tTopR = tTRL;
	dBottomR = tBRL - tBottomR;
	tBottomR = tBRL;
}
if (TileHasMask(collLayer, global.mask_stairsLeft, tLeft, tTLL) ||
	TileHasMask(collLayer, global.mask_stairsLeft, tLeft, tBLL)) {
	dTopL = tTLL - tTopL;
	tTopL = tTLL;
	dBottomL = tBLL - tBottomL;
	tBottomL = tBLL;
}
	
var dYC = 0;
if (TileHasMask(collLayer, global.mask_stairsRight, tX, tYR)) {
	dYC = dYCR;
} else if (TileHasMask(collLayer, global.mask_stairsLeft, tX, tYL)) {
	dYC = dYCL;
}

if (_dX > 0 && _dY > 0) {				// -------------------- RIGHT ; DOWN --------------------
	if (ShouldCollide(collLayer, 1, tRight, tTopR, tX, tY)) {
		x = (tRight << TILE_SHIFT) - _right - 1;
		
		if (ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY)) {
			y = ((tBottomL - dBottomL) << TILE_SHIFT) - _bottom - 1 - dYC;
		}
	} else if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY) ||
		ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY)) {
		y = ((tBottomR - dBottomR) << TILE_SHIFT) - _bottom - 1 - dYC;
	}
} else if (_dX > 0 && _dY == 0) {		// -------------------- RIGHT --------------------
	if (ShouldCollide(collLayer, 1, tRight, tTopR, tX, tY) ||
		ShouldCollide(collLayer, 1, tRight, tBottomR, tX, tY)) {
		x = (tRight << TILE_SHIFT) - _right - 1;
	}
} else if (_dX > 0) {					// -------------------- RIGHT ; UP --------------------
	if (ShouldCollide(collLayer, 1, tRight, tBottomR, tX, tY)) {
		x = (tRight << TILE_SHIFT) - _right - 1;
		
		if (ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY)) {
			y = ((tTopL - dTopL) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
		}
	} else if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY) ||
		ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY)) {
		y = ((tTopR - dTopR) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
	}
} else if (_dX < 0 && _dY > 0) {		// -------------------- LEFT ; DOWN --------------------
	if (ShouldCollide(collLayer, 3, tLeft, tTopL, tX, tY)) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		
		if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY)) {
			y = ((tBottomR - dBottomR) << TILE_SHIFT) - _bottom - 1 - dYC;
		}
	} else if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY) ||
		ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY)) {
		y = ((tBottomL - dBottomL) << TILE_SHIFT) - _bottom - 1 - dYC;
	}
} else if (_dX < 0 && _dY == 0) {		// -------------------- LEFT --------------------
	if (ShouldCollide(collLayer, 3, tLeft, tTopL, tX, tY) ||
		ShouldCollide(collLayer, 3, tLeft, tBottomL, tX, tY)) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
	}
} else if (_dX < 0) {					// -------------------- LEFT ; UP --------------------
	if (ShouldCollide(collLayer, 3, tLeft, tBottomL, tX, tY)) {
		x = (tLeft << TILE_SHIFT) + TILE_SIZE + _left;
		
		if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY)) {
			y = ((tTopR - dTopR) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
		}
	} else if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY) ||
		ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY)) {
		y = ((tTopL - dTopL) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
	}
} else if (_dY > 0) {					// -------------------- DOWN --------------------
	if (ShouldCollide(collLayer, 2, tLeft, tBottomL, tX, tY))
		y = ((tBottomL - dBottomL) << TILE_SHIFT) - _bottom - 1 - dYC;
	else if (ShouldCollide(collLayer, 2, tRight, tBottomR, tX, tY))
		y = ((tBottomR - dBottomR) << TILE_SHIFT) - _bottom - 1 - dYC;
} else if (_dY < 0) {					// -------------------- UP --------------------
	if (ShouldCollide(collLayer, 0, tLeft, tTopL, tX, tY))
		y = ((tTopL - dTopL) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
	else if (ShouldCollide(collLayer, 0, tRight, tTopR, tX, tY))
		y = ((tTopR - dTopR) << TILE_SHIFT) + TILE_SIZE + _top - dYC;
}

var tX = (x + 0.5 * _right - 0.5 * _left) >> TILE_SHIFT;
var tY = (y + 0.5 * _bottom - 0.5 * _top) >> TILE_SHIFT;

if (TileHasMask(collLayer, global.mask_riseDepth, tX, tY)) {
	depth -= 100;
} else if (TileHasMask(collLayer, global.mask_lowerDepth, tX, tY)) {
	depth += 100;
}

if (_dY != 0) {
	var yPlayer = y;
	for (var i = 0; i < instance_count; i++)
		with (instance_id[i])
			if (object_is_ancestor(object_index, obj_physical))
				if (changeDepth)
					ChangeInstanceDepth(yPlayer);
}