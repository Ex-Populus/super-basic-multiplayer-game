/// @description  Callback function for netcode pong
/// @argument     msg_map - input map containing data
function scr_cb_pong(argument0) {

	var msg_map = argument0;

	var other_id = ds_map_find_value(msg_map, "from")
	var other_to = ds_map_find_value(msg_map, "to")
	var other_time = ds_map_find_value(msg_map, "time")

#macro PINGFILTER 0.9

	with(obj_lockstep) {
		// check if to me
	
		if(other_to != player_id) {
			return;
		}
	
		//show_debug_message("Pong from id " + string(other_id));

		// get player number
		var other_number = ds_list_find_index(player_list, other_id);
	
		if(other_number >= 0 and other_number < session_players) {
			// validate ping
			while(ds_priority_size(ping_seq) > 0) {
				var min_ping_time = ds_priority_find_min(ping_seq)
				if(min_ping_time < other_time) { // old ping, never recieved
					ds_priority_delete_min(ping_seq);
				}
				else if(min_ping_time == other_time) { // current ping, calculate
					var time = floor(get_timer()/1000);
					var ping = time - other_time;	
					var prev_ping = ds_list_find_value(ping_list, other_number);

					if(not is_undefined(prev_ping)) {
						var ping = prev_ping*PINGFILTER + ping*(1-PINGFILTER);
					}
					ds_list_replace(ping_list, other_number, ping);
					break;
				}
				else {
					break;   
				}
			
			}
		}
	
	}

}
