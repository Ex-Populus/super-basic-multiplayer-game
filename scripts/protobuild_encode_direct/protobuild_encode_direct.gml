/// @description  Encodes a buffer using data from arguments
/// @argument     buff - index of buffer to write into
/// @argument     msg_name - name of the protobuild message spec
/// @argument     value - first value to add in
/// @argument     ... - additional values
function protobuild_encode_direct() {


	if(argument_count < 2) {
		show_error("Invalid number of arguments", true);
	}
	var buff = argument[0];
	var msg_name = string(argument[1]);

	// check if it exists
	var msg = ds_map_find_value(global.protobuild_msg_spec, msg_name);
	if(is_undefined(msg)) {
		show_debug_message("WARNING: message " + string(msg_name) + " not found");
		return false;
	}

	var type_list = ds_map_find_value(msg, "types");
	var msg_id = ds_map_find_value(msg, "id");

	buffer_write(buff, buffer_u16, msg_id);
	for(var i=0; i<ds_list_size(type_list) and i+2<argument_count; i++) {
		var spec_type= ds_list_find_value(type_list, i);
		var insert_val = argument[i+2];
	
		switch(spec_type) {
			case PROTOBUILD_TYPE.boolean:
			case PROTOBUILD_TYPE.u8:
				buffer_write(buff, buffer_u8, insert_val);
				break;
			case PROTOBUILD_TYPE.s8:
				buffer_write(buff, buffer_s8, insert_val);
				break;
			case PROTOBUILD_TYPE.u16:
				buffer_write(buff, buffer_u16, insert_val);
				break;
			case PROTOBUILD_TYPE.s16:
				buffer_write(buff, buffer_s16, insert_val);
				break;
			case PROTOBUILD_TYPE.u32:
				buffer_write(buff, buffer_u32, insert_val);
				break;
			case PROTOBUILD_TYPE.s32:
				buffer_write(buff, buffer_s32, insert_val);
				break;
			case PROTOBUILD_TYPE.f32:
				buffer_write(buff, buffer_f32, insert_val);
				break;
			case PROTOBUILD_TYPE.u64:
				buffer_write(buff, buffer_u64, insert_val);
				break;
			case PROTOBUILD_TYPE.f64:
				buffer_write(buff, buffer_f64, insert_val);
				break;
			default:
				var tell = buffer_tell(buff);
				buffer_fill(buff, tell, buffer_u8, 0, spec_type);
				buffer_write(buff, buffer_text, string_copy(insert_val, 1, spec_type));
				buffer_seek(buff, buffer_seek_start, tell + spec_type);
		}
	
	}
	
	return true;

}
