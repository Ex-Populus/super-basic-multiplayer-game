/// @description lobby gui

showIPBox = false;
labelText = "Enter Host IP:";
defaultX = 5000;
defaultY = 5000;

var guiTop = 200;
var buttonWidth = 280;
var buttonHeight = 80;
var centerX = (display_get_gui_width() / 2);
var centerY = (display_get_gui_height() / 2);
var buttonX = centerX - (buttonWidth /2);

btnHost = scr_create_button(buttonX, guiTop, buttonWidth, buttonHeight, "Host Game", scr_goto_mp_game);
btnJoin = scr_create_button(buttonX, btnHost.y + buttonHeight + 40, buttonWidth, buttonHeight, "Join Game", -1);

var ipBoxTotalWidth = 280;
ipBoxX = centerX - (ipBoxTotalWidth / 2);
ipBoxY = btnJoin.y + buttonHeight + 40;

ipBox = instance_create_layer(defaultX, defaultY, "Instances", obj_ip_input_box);
ipBoxIpString = "";
ipBoxGoButton = ipBox.button;
