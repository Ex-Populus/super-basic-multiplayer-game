// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ip_string_only(str){
	returnString = "";
	
	if (is_string(str)) {
		for (var i = 1; i <= string_length(str); ++i) {
			var letter = string_char_at(str, i);
			switch(letter) {
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
				case ".":
					returnString += letter;
					break;
			}
	  }
		
		return returnString;
	}
	
	return str;
}