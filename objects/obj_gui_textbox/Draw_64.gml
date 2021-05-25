/// @description

draw_set_color(c_white);
draw_roundrect(x, y, x + width, y + height, true);

draw_text(x + 10, y + 10, boxText);

draw_text(1, 100, string(string_length(keyboard_string)) + "/" + string(maxLength));
