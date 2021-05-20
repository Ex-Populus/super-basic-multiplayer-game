/// @description  Decode buffer containing protobuild packets and pass map to callbacks
/// @argument     buff - index of buffer to decode
/// @argument     *size - size of buffer (if not provided, buffer_get_size() wil be used)
function protobuild_decode_to_map() {

	if(argument_count < 1) {
		show_error("Invalid argument count", true);	
	}

	var buff = argument[0];

	if(argument_count > 1) {
		var size = argument[1];
	}
	else {
		var size = buffer_get_size(buff);	
	}

	// check size
	if(size < 4) {
		show_debug_message("Invalid message: too smol");
		return false;
	}

	buffer_seek(buff, buffer_seek_start, 0);
	while(buffer_tell(buff) < size) {

		// check header
		var header = buffer_read(buff, buffer_u16);
		if(header != global.protobuild_code) {
			show_debug_message("Invalid header");
			return false;
		}

		var prot_size = buffer_read(buff, buffer_u16);
	
		var buff_chunk_start = buffer_tell(buff);
		// read
		while(buffer_tell(buff)-buff_chunk_start < prot_size) {
			var msg_id = buffer_read(buff, buffer_u16);
			var msg_map = ds_list_find_value(global.protobuild_msg_index, msg_id);

			if(not is_undefined(msg_map)) {
	
				var callback = ds_map_find_value(msg_map, "callback")
		
				var spec = ds_map_find_value(msg_map, "spec");
				var send_map = ds_map_create();
	
				for(var i=0; i<ds_list_size(spec); i++) {
					var spec_map = ds_list_find_value(spec, i);
					var spec_type = ds_map_find_value(spec_map, "type");
					var spec_name = ds_map_find_value(spec_map, "name");
		
					if(is_undefined(spec_type)) {
						show_error("Spec type undef error", true);	
					}
					var value = protobuild_decode_value(buff, spec_type);
					ds_map_add(send_map, spec_name, value);
				}
	
				if(script_exists(callback)) {
					script_execute(callback, send_map);
				}
				else {
					show_debug_message("Message " + string(msg_id) + " has no callback");	
				}
				if(ds_exists(send_map, ds_type_map)) {
					ds_map_destroy(send_map);
				}
			}
			else {
				show_debug_message("Message " + string(msg_id) + " not in protocol");	
			}
		}
	}
	
	return true;

}
