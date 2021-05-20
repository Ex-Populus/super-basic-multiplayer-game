/// @description  Callback function for netcode ping.
/// @argument     msg_map - input map containing data
function scr_cb_ping(argument0) {

	var msg_map = argument0;

	var other_id = ds_map_find_value(msg_map, "from")
	var other_frame = ds_map_find_value(msg_map, "frame")
	var other_time = ds_map_find_value(msg_map, "time")

	//show_debug_message("Ping from id " + string(other_id) + " at frame " + string(other_frame));

	with(obj_lockstep) {
		// get player number
		var other_number = ds_list_find_index(player_list, other_id);
	
		if(other_number >= 0 and other_number < session_players and other_id != player_id) {
			// update stat
			ds_list_replace(stat_list, other_number, other_frame);
			show_debug_message("Player " + string(other_number) + " on frame " + string(other_frame));
			var buff = protobuild_buffer("pong")
			protobuild_encode_direct(buff, "pong", player_id, other_id, other_time);
			netcode_relay_tx(buff);
			buffer_delete(buff);
		}
	
	}

}
