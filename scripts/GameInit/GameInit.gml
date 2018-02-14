global.floorCollisions = ds_map_create();
global.layerDelta = 100;
global.layerCollideDelta = 40;
global.playerDepthDelta = 10;

global.mask_walkable = 1;		// ____ ____ ____ ___1
global.mask_riseDepth = 8;		// ____ ____ ____ 1___
global.mask_lowerDepth = 4;		// ____ ____ ____ _1__
global.mask_blockTop = 128;		// ____ ____ 1___ ____
global.mask_blockBot = 64;		// ____ ____ _1__ ____
global.mask_blockRight = 32;	// ____ ____ __1_ ____
global.mask_blockLeft = 16;		// ____ ____ ___1 ____
global.mask_stairsRight = 512;	// ____ __1_ ____ ____
global.mask_stairsLeft = 256;	// ____ ___1 ____ ____

global.states = ds_map_create();
global.loadedRooms = ds_list_create();
global.flags = ds_list_create();

// AUDIO

global.audioMaster = 1;
global.audioSounds = 1;
global.audioMusic = 1;

// CAMERAS FOR RESOLUTION

global.mainCam = 0;

room_goto(room_next(room));
