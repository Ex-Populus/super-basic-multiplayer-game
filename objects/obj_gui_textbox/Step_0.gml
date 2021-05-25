/// @description 

boxText = "";

// Clipboard
//cbText = "";
//if (keyboard_check(vk_control) && keyboard_check(ord("V")) && clipboard_has_text()) {
//	boxText = clipboard_get_text();
//}

//if(boxText!="" && (keyboard_check_pressed(ord("V")) || keyboard_check_pressed(vk_control))) {
//	boxText = string_insert(cbText, boxText, cursorPos);
//}

// Cursor
//if (keyboard_check_pressed(vk_left)) {
//	cursorPos = clamp(cursorPos - 1, 1, 16);
//}
//if (keyboard_check_pressed(vk_right)) {
//	cursorPos = clamp(cursorPos + 1, 1, 16);
//}

keyboard_string = scr_ip_string_only(keyboard_string)
if string_length(keyboard_string) > 15 {
	keyboard_string = string_copy(keyboard_string, 1, maxLength);
}

boxText = string_length(keyboard_string) < maxLength ? keyboard_string + cursor : keyboard_string;
