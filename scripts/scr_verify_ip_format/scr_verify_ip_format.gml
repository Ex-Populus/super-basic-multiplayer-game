// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_verify_ip_format(ip_addr) {
	if (!is_string(ip_addr)) {
		return false;
	}
	
	var dotCount = 0;
	var octets = ds_list_create();
	var octet = "";
	
	for (var i = 1; i <= string_length(ip_addr); ++i) {
		var char = string_char_at(ip_addr, i);
		
		switch(char) {
			case ".":
				if (string_length(octet) > 0 && string_length(octet) < 4) {
					ds_list_add(octets, octet);
					//show_debug_message("-- Adding octet: " + octet);
				} else {
					//show_debug_message("-- (" + octet + ")");
				}
				octet = "";
				dotCount += 1;
				break;

			case "0":
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
			case "8":
			case "9":
				octet += char;
				//show_debug_message("++ " + octet);
				break;
					
			default:
				return false;
		}
	}
	
	if (string_length(octet) > 0 && string_length(octet) < 4) {
		ds_list_add(octets, octet);
		//show_debug_message("-- Adding octet: " + octet);
	} else {
		//show_debug_message("-- (" + octet + ")");
	}
	
	//show_debug_message("dotCount=" + string(dotCount));
	//show_debug_message("octets=" + string(ds_list_size(octets)));
	
	return (dotCount == 3 && ds_list_size(octets) == 4);
}