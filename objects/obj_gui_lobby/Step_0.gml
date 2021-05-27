/// @description 

showIPBox = btnJoin.clicked;

if (showIPBox) {
	ipBox.x = ipBoxX;
	ipBox.y = ipBoxY;
	
	ipBoxIpString = ipBox.ipString;
	ipString = string_replace_all(ipBoxIpString, "|", "");
	
	if (ipBoxGoButton.clicked) {
		if (scr_verify_ip_format(ipString)) {
			//show_debug_message("GOOD IP! " + ipString);
			with (obj_connection) {
				server_addr = other.ipString;
			}
		} else {
			show_debug_message("BAD IP! " + ipString);
			ipBoxGoButton.clicked = false;
		}
	}
} else {
	ipBox.x = defaultX;
	ipBox.y = defaultY;
}
