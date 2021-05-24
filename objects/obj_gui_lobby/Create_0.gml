/// @description lobby gui

var buttonWidth = 280;
var buttonHeight = 80;
var centerX = (display_get_gui_width() / 2) - (buttonWidth / 2);

scr_create_button(centerX, 200, buttonWidth, buttonHeight, "Host Game", scr_goto_mp_game);
scr_create_button(centerX, 320, buttonWidth, buttonHeight, "Join Game", -1);