/// @description 

// defaults
height = 40;
boxWidth = 220;
buttonWidth = 50;
spacer = 10;
ipString = "";


// create objects
textbox = instance_create_layer(x, y, "Instances", obj_gui_textbox);
button = scr_create_button(x, y, "Instances", obj_gui_button, -1);

// set properties
textbox.width = boxWidth;
textbox.height = height;
textbox.maxLength = 15;
textbox.x = x;
textbox.y = y;

button.width = buttonWidth;
button.height = height;
button.x = textbox.x + boxWidth + spacer;
button.y = y;
button.text = "Go";
