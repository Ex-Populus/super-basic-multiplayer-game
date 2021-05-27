/// @description  Creates a new gui button
/// @argument     x - button initial x position
/// @argument     y - button initial y position
/// @argument     width - button width
/// @argument     height - button height
/// @argument     text - button text
/// @argument     script -  Callback for button click
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