global.pause								= true;
global.viewWidth							= camera_get_view_width(view_camera[0]);
global.viewHeight							= camera_get_view_height(view_camera[0]);

// -------------NORMAL-------------

// KEYBOARD

global.keyUp								= ord("Z");
global.keyDown								= ord("S");
global.keyLeft								= ord("Q");
global.keyRight								= ord("D");
global.keySprint							= vk_shift;

global.keyInteract							= ord("E");
global.keyTogglePreyMode					= ord("X");

global.keyToggleLight						= mb_middle;
global.keyToggleLaser						= mb_right;
global.keySendSphere						= mb_left;

global.keyMap								= ord("M");
global.keyMenu								= vk_escape;

// GAMEPAD

gamepad_set_axis_deadzone(0, 0.4);
gamepad_set_button_threshold(0, 0.1);

global.gpSprint								= gp_shoulderlb;	// LT

global.gpInteract							= gp_face1;			// A
global.gpToggleLight						= gp_shoulderl;		// LB
global.gpToggleLaser						= gp_shoulderr;		// RB
global.gpTogglePreyMode						= gp_face3;			// X
global.gpSendSphere							= gp_shoulderrb;	// RT
global.gpMap								= gp_face4;			// Y
global.gpMenu								= gp_start;			// Start

// -------------PREY-------------

// -------------DISPLAY----------

display_set_gui_size(global.viewWidth, global.viewHeight);

// -------------PAGES------------

enum menuPage {
	main,
	settings,
	audio,
	graphics,
	controls,
	height,
}

enum menuElementType {
	scriptRunner,
	pageTransfer,
	slider,
	shift,
	toggle,
	input,
}

// CREATE MENU PAGES

ds_menuMain = CreateMenuPage(
	["RESUME",				menuElementType.scriptRunner,	ResumeGame],
	["SETTINGS",			menuElementType.pageTransfer,	menuPage.settings],
	["EXIT",				menuElementType.scriptRunner,	ExitGame],
);

ds_settings = CreateMenuPage(
	["AUDIO",				menuElementType.pageTransfer,	menuPage.audio],
	["GRAPHICS",			menuElementType.pageTransfer,	menuPage.graphics],
	["CONTROLS",			menuElementType.pageTransfer,	menuPage.controls],
	["BACK",				menuElementType.pageTransfer,	menuPage.main],
);

ds_menuAudio = CreateMenuPage(
	["MASTER",				menuElementType.slider,			ChangeVolume,			1,				[0,1]],
	["SOUNDS",				menuElementType.slider,			ChangeVolume,			1,				[0,1]],
	["MUSIC",				menuElementType.slider,			ChangeVolume,			1,				[0,1]],
	["BACK",				menuElementType.pageTransfer,	menuPage.settings],
);

ds_menuGraphics = CreateMenuPage(
	["RESOLUTION",			menuElementType.shift,			ChangeResolution,		0,				["384 x 216", "768 x 432", "1152 x 648", "1536 x 874", "1920 x 1080"]],
	["WINDOW MODE",			menuElementType.toggle,			ChangeWindowMode,		1,				["FULLSCREEN", "WINDOWED"]],
	["BACK",				menuElementType.pageTransfer,	menuPage.settings],
);

ds_menuControls = CreateMenuPage(
	["UP",					menuElementType.input,			"keyUp",				ord("Z")],
	["DOWN",				menuElementType.input,			"keyDown",				ord("S")],
	["LEFT",				menuElementType.input,			"keyLeft",				ord("Q")],
	["RIGHT",				menuElementType.input,			"keyRight",				ord("D")],
	["SPRINT",				menuElementType.input,			"keySprint",			vk_shift],
	["INTERACT",			menuElementType.input,			"keyInteract",			ord("E")],
	["TOGGLE PREY MODE",	menuElementType.input,			"keyTogglePreymode",	ord("X")],
	["TOGGLE LIGHT",		menuElementType.input,			"keyToggleLight",		mb_middle],
	["TOGGLE LASER",		menuElementType.input,			"keyToggleLaser",		mb_right],
	["SEND SPHERE",			menuElementType.input,			"keySendSphere",		mb_left],
	["MAP",					menuElementType.input,			"keyMap",				ord("M")],
	["MENU",				menuElementType.input,			"keyMenu",				vk_escape],
	["BACK",				menuElementType.pageTransfer,	menuPage.settings],
);

page = 0;
menuPages = [ds_menuMain, ds_settings, ds_menuAudio, ds_menuGraphics, ds_menuControls];

var i = 0, array_len = array_length_1d(menuPages);
repeat (array_len) {
	menuOption[i] = 0;
	i++;
}