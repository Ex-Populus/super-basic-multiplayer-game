/// @description  Creates a protobuild buffer including header and length
/// @argument     message - first message to add to buffer
/// @argument     ... - additional messages
function protobuild_buffer() {


	var size = 0;
	// loop through arguments and construct buffer
	for(var i=0; i<argument_count; i++) {
		size += protobuild_size(argument[i]);
	}

	var buff = buffer_create(size+4, buffer_fixed, 1);
	buffer_write(buff, buffer_u16, global.protobuild_code);
	buffer_write(buff, buffer_u16, size);
	return buff;

}
