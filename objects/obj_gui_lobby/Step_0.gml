/// @description 

showIPBox = btnJoin.clicked;

if (showIPBox) {
	ipBox.x = ipBoxX;
	ipBox.y = ipBoxY;
	
	ipBoxIpString = ipBox.ipString;
	
	if (ipBoxGoButton.clicked) {
		if (scr_verify_ip_format(ipBoxIpString)) {
			show_debug_message("GOOD IP! " + ipBoxIpString);
		} else {
			show_debug_message("BAD IP! " + ipBoxIpString);
			ipBoxGoButton.clicked = false;
		}
	}
} else {
	ipBox.x = defaultX;
	ipBox.y = defaultY;
}
