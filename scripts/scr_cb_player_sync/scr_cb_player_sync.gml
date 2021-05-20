/// @description  Callback function for netcode sync
/// @argument     msg_map - input map containing sync data
function scr_cb_player_sync(argument0) {

	var msg_map = argument0;

	var other_id = ds_map_find_value(msg_map, "id")
	show_debug_message("MSG: Update from id " + string(other_id));

	with(obj_lockstep) {
		if(game_state != GAMESTATE.resync) {
			show_debug_message("Not in resync, ignoring")
			return;
		}
	
		// get player number
		var other_number = ds_list_find_index(player_list, other_id);
	
		if(other_number >= 0 and other_number < session_players) {
			show_debug_message("Sync id " + string(other_id) + " player " + string(other_number));
			
			// update instance
			var instance = ds_list_find_value(instance_list, other_number);
			if(is_undefined(instance) or not instance_exists(instance)) {
				instance = scr_spawn_player(other_number);
				instance.x = ds_map_find_value(msg_map, "x")
				instance.y = ds_map_find_value(msg_map, "y")
				instance.hp = ds_map_find_value(msg_map, "hp")
				instance.effects = ds_map_find_value(msg_map, "effects")
				ds_list_replace(instance_list, other_number, instance);
				show_debug_message("Created instance for id " + string(other_id) + " player " + string(other_number))
			}
		
			// update sync frame number
			var other_frame = ds_map_find_value(msg_map, "frame");
			if(frame_number < other_frame) {
				frame_number = other_frame;	
			}
	
			// update frame list
			if(ds_list_find_index(frame_list, other_id) < 0) {
				ds_list_add(frame_list, other_id);
				show_debug_message("Added player " + string(other_id) + " to frame_list");
			}
		}
	
	}

}
