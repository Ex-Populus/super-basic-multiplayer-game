/// @description  Callback for data recieved
/// @argument     buff - buffer index for recieve buffer
/// @argument     *size - size of buffer
function netcode_relay_rx() {


	if(argument_count < 1) {
		show_error("Invalid argument count", true);	
	}

	var buff = argument[0];
	buffer_seek(buff, buffer_seek_start, 0);

	if(argument_count > 1) {
		var size = argument[1];
	}
	else {
		var size = buffer_get_size(buff);	
	}

	//show_debug_message("RX: " + string(size));
	protobuild_decode_to_map(buff, size);

}
