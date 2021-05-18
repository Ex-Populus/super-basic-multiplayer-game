// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_button(x, y, width, height, text, script){
	var button = instance_create_layer(x, y, "Instances", obj_gui_button);
	button.width = width;
	button.height = height;
	button.x = x;
	button.y = y;
	button.text = text;
	button.script = script;
	
	return button;
}