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

room_goto(room_next(room));

// WINDOW & RESOLUTION

var sWidth, sHeight, gWidth, gHeight, aspect, cScale, offSet;

gWidth = view_wport[0];
gHeight = view_hport[0];
aspect = (gWidth / gHeight);
sHeight = display_get_height();
sWidth = (sHeight * aspect);
cScale = (sHeight / gHeight);
offSet = 256;

if !window_get_fullscreen()

{ window_set_size((sWidth - offSet),(sHeight - offSet)); }

display_set_gui_size(sWidth,sHeight);