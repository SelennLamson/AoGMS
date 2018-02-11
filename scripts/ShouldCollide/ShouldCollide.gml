var map = argument0;
var block = argument1;
var xx = argument2;
var yy = argument3;
var tx = argument4;
var ty = argument5;

switch (block) {
	case 0:				// Top
		if (yy == ty)
			return !TileHasMask(map, global.mask_walkable, xx, yy);
		else
			return !TileHasMask(map, global.mask_walkable, xx, yy) || TileHasMask(map, global.mask_blockBot, xx, yy);
	case 1:				// Right
		if (xx == tx)
			return !TileHasMask(map, global.mask_walkable, xx, yy);
		else
			return !TileHasMask(map, global.mask_walkable, xx, yy) || TileHasMask(map, global.mask_blockLeft, xx, yy);
	case 2:				// Bottom
		if (yy == ty)
			return !TileHasMask(map, global.mask_walkable, xx, yy);
		else
			return !TileHasMask(map, global.mask_walkable, xx, yy) || TileHasMask(map, global.mask_blockTop, xx, yy);
	default:			// Left
		if (xx == tx)
			return !TileHasMask(map, global.mask_walkable, xx, yy);
		else
			return !TileHasMask(map, global.mask_walkable, xx, yy) || TileHasMask(map, global.mask_blockRight, xx, yy);
}