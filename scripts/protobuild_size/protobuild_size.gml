/// @description  Get the length of a protocol message
/// @argument     msg_name - name of message
/// @return       size of of the message in terms of how many bytes in the buffer it takes up
function protobuild_size(argument0) {

	var msg_name = string(argument0);

	// check if it exists
	var msg = ds_map_find_value(global.protobuild_msg_spec, msg_name);
	if(is_undefined(msg)) {
		show_debug_message("WARNING: message " + string(msg_name) + " not found");
		return undefined;
	}
	else {
		return ds_map_find_value(msg, "size") + 2; // the 2 accounts for 2 ID
	}

}
