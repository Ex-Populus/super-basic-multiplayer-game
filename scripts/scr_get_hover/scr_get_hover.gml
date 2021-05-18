function scr_get_hover(){
	var mouseX = device_mouse_x_to_gui(0);
	var mouseY = device_mouse_y_to_gui(0);
	return point_in_rectangle(mouseX, mouseY, x, y, x + width, y + height);
}