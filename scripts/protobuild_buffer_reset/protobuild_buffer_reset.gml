/// @description  Resets buffer to zeros, and write pointer to just after header/size
/// @argument     buff - index of buffer to reset
function protobuild_buffer_reset(argument0) {

	var buff = argument0;
	buffer_fill(buff, 4, buffer_u8, 0, buffer_get_size(buff)-4);
	buffer_seek(buff, buffer_seek_start, 4);

}
