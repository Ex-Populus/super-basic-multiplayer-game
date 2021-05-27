/// @description render label text

if (scr_verify_ip_format(ipString)) {
	draw_set_color(c_lime);
} else {
	draw_set_color(c_red);
}
draw_text(ipBox.x, ipBox.y - 24, labelText);

draw_set_color(c_white);
