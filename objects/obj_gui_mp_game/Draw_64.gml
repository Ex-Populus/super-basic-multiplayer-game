/// @description 

var centerX = (display_get_gui_width() / 2);
var centerY = (display_get_gui_height() / 2);

if (showWatingMessage) {
	draw_set_color(c_white);
	draw_set_halign(fa_middle);
	draw_text(centerX, centerY, textWaiting);
	draw_set_halign(fa_left);
}
