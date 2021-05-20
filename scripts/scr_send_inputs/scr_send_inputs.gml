/// @description  Send the input history
function scr_send_inputs() {

	with(obj_lockstep) {
		// detect earliest frame
		var earliest = frame_number;
		for(var i=0; i<ds_list_size(stat_list); i++) {
			var frame = ds_list_find_value(stat_list, i);
			if(not is_undefined(frame)) {
				if(is_undefined(earliest) or frame < earliest) {
					earliest = frame;
				}
			}
		}

		// delete old frames
		while(ds_priority_size(input_history)) {
			var input = ds_priority_find_min(input_history);
			var pri = ds_priority_find_priority(input_history, input);
		
			if(pri < earliest) {
				ds_map_destroy(input);
				ds_priority_delete_min(input_history);
				//show_debug_message("Dumping " + string(pri) + " from input buffer");
			}
			else {
				break;	
			}
		}
	
		// debug
		var low = ds_priority_find_min(input_history);
		var hi = ds_priority_find_max(input_history);
		show_debug_message("Sending " + string(low[?"frame"]) + "-" + string(hi[?"frame"]));

		// send out all old frames
		if(ds_priority_size(input_history)) {
			var buff = protobuild_buffer();
			var copy_history = ds_priority_create();
			ds_priority_copy(copy_history, input_history);
	
			while(ds_priority_size(copy_history)) {
				var input = ds_priority_delete_min(copy_history);
				protobuild_buffer_extend(buff, "player_input");
				protobuild_encode_from_map(buff, "player_input", input);	
			}

			netcode_relay_tx(buff);
			netcode_relay_rx(buff);
			buffer_delete(buff);
			ds_priority_destroy(copy_history);
		}
	
	}

}
