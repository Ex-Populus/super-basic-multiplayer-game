/// @description  Check how many player's worth of inputs we have for a given frame
/// @argument     target_frame - frame number to check
function scr_check_inputs(argument0) {

	var target_frame = argument0;

	with(obj_lockstep) {
		if(game_state != GAMESTATE.go) {
			show_debug_message("Not in Go, ignoring")
			return 0;
		}
	
		// check each instance
		var instance_ready = 0;
		for(var i=0; i<ds_list_size(instance_list); i++) {
			var instance = ds_list_find_value(instance_list, i);
			with(instance) {
				// extract ds_priority
				var got = false;

				while(ds_priority_size(input_buffer) > 0) {
					var val = ds_priority_find_min(input_buffer);
					var pri = ds_priority_find_priority(input_buffer, val);
				
					if(pri < target_frame) { // old frame
						ds_list_destroy(val);
						ds_priority_delete_min(input_buffer);
						//show_debug_message("Found old input frame " + string(pri));
					}
					else if(pri == target_frame) { // got frame
						got = true;
						break;
					}
					else if(pri > target_frame) { // future frame
						break;
					}
				}
			
				if(got) {
					instance_ready += 1;	
				}
			}
		}
	
		//show_debug_message("Frame: " + string(target_frame) + " check inputs got " + string(instance_ready));
		return instance_ready;
	
	}

}
