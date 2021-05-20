/// @description  Resize a buffer to a new length
/// @argument     buff - index of buffer to write into
/// @argument     msg_name - name of the protobuild message spec to add
/// @argument     ... - additional messages
function protobuild_buffer_resize() {

	if(argument_count < 1) {
		show_error("Invalid argumnet count", true);	
	}

	var buff = argument[0];
	if(not buffer_exists(buff)) {
		show_error("Buffer " + string(buff) + " does not exist", true);	
	}

	var size = 0;
	// loop through arguments and construct buffer
	for(var i=1; i<argument_count; i++) {
		size += protobuild_size(argument[i]);
	}

	buffer_resize(buff, size+4);
	buffer_seek(buff, buffer_seek_start, 0);
	buffer_write(buff, buffer_u16, global.protobuild_code);
	buffer_write(buff, buffer_u16, size);
	return buff;

}
