/// @description  Callback function for player input
/// @argument     msg_map - input map containing input
function scr_cb_player_input(argument0) {

	var msg_map = argument0;

	var other_id = ds_map_find_value(msg_map, "id")

	with(obj_lockstep) {
	
		// get player number
		var other_number = ds_list_find_index(player_list, other_id);
	
		if(other_number >= 0 and other_number < session_players) {
			
			// check frame
			var other_frame = ds_map_find_value(msg_map, "frame");
			//show_debug_message("Recieved input frame: " + string(other_frame) + " from " + string(other_number));
			if(other_frame < frame_number) { // do not accept old frames
				return;
			}
		
			// update latest frame for tracking
			// TODO: (RN) Figure out the other_id !- player_id issue here
			//       For some reason they're always equal and input_latest_frame is never updated
			//       Turned it off for now
			//if(other_id != player_id and other_frame > input_latest_frame) {
			//	input_latest_frame = other_frame;	
			//}
			if(other_frame > input_latest_frame) {
				input_latest_frame = other_frame;
			}
		
			// update instance
			var instance = ds_list_find_value(instance_list, other_number);
			if(not is_undefined(instance) and instance_exists(instance)) {
				with(instance) {
					// TODO: possibly check if this value exists
					var buff_map = ds_list_create()
					ds_list_add(buff_map, ds_map_find_value(msg_map, "hin"), ds_map_find_value(msg_map, "vin"), ds_map_find_value(msg_map, "fire"));
					ds_priority_add(input_buffer, buff_map, other_frame);
				}
			}
			else {
				show_debug_message("Instance doesn't exist!");
				return;
			}
		}
	
	}

}
