/// @description  Increase a buffer, adding more messages to it
/// @argument     buff - index of buffer to write into
/// @argument     msg_name - name of the protobuild message spec to add
/// @argument     ... - additional messages
function protobuild_buffer_extend() {

	if(argument_count < 1) {
		show_error("Invalid argumnet count", true);	
	}

	var buff = argument[0];
	if(not buffer_exists(buff)) {
		show_error("Buffer " + string(buff) + " does not exist", true);	
	}

	var size = 0;
	// loop through arguments and construct buffer size
	for(var i=1; i<argument_count; i++) {
		size += protobuild_size(argument[i]);
	}

	// resize buffer to new size
	var orig_size = buffer_get_size(buff)
	buffer_resize(buff, orig_size+size);

	// re-write size value in header
	var peek_buff_size = buffer_peek(buff, 2, buffer_u16);
	buffer_poke(buff, 2, buffer_u16, peek_buff_size + size);

	return buff;

}
