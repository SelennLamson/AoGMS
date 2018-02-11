var groundLayer = argument0;

var collDepth = layer_get_depth(groundLayer) - global.layerCollideDelta;
var collName = "Collisions" + string(collDepth);
var collLayer = layer_get_id(collName);
var collTilemap = layer_tilemap_get_id(collLayer);

var groundTilemap = layer_tilemap_get_id(groundLayer);
var width = tilemap_get_width(groundTilemap);
var height = tilemap_get_height(groundTilemap);
		
for (var xx = 0; xx < width; xx++) {
	for (var yy = 0; yy < height; yy++) {
		var groundTile = tilemap_get(groundTilemap, xx, yy) & tile_index_mask;
		if (groundTile != 0) {
			AddTileMask(collTilemap, global.mask_walkable, xx, yy);
			
			if (groundTile == 78 || groundTile == 81) {
				AddTileMask(collTilemap, global.mask_blockLeft, xx, yy);
				if (xx != 0)
					AddTileMask(collTilemap, global.mask_blockRight, xx - 1, yy);
			}
			if (groundTile == 80 || groundTile == 81) {
				AddTileMask(collTilemap, global.mask_blockRight, xx, yy);
				if (xx != width - 1)
					AddTileMask(collTilemap, global.mask_blockLeft, xx + 1, yy);
			}
		}
	}
}

ds_map_add(global.floorCollisions, collDepth, collTilemap);