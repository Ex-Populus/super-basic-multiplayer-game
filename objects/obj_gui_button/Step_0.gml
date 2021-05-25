/// @description

var hover = scr_get_hover();
var click = hover && mouse_check_button_pressed(mb_left);

hoverVal = lerp(hoverVal, hover, 0.2);

if (click) {
	clicked = true;
	
	if (script > -1) {
		script_execute(script);
	}
}