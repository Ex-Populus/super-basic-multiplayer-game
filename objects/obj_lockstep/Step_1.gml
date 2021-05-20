/// @description main lockstep functionality

// don't run too-far ahead
var max_late = get_timer() - 1000000*(1+frame_skip)*(1+input_delay)/room_speed;
if(frame_time_next < max_late) {
	frame_time_next = max_late;
}

// this is kind of like delta-time
if(get_timer() >= frame_time_next) {
	
	switch(game_state) {
		case GAMESTATE.registering:
			// registration process: wait for players to connect and register
			// then collapse the registered player IDs into player number
			// NOTE: there is no session management here, the lowest n players become players
			
			debug_text = "Frame " + string(frame_number) + " registering " + string(ds_list_size(player_list)) + "/" + string(session_players);
			show_debug_message(debug_text);
			var buff = protobuild_buffer("registration")
			protobuild_encode_direct(buff, "registration", player_id);
			
			netcode_relay_tx(buff);
			netcode_relay_rx(buff); // loopback
			buffer_delete(buff);
			
			if(ds_list_size(player_list) >= session_players) { // enough players, game start
				// TODO: deal with ID collisions
				
				// sort list to get player IDs
				ds_list_sort(player_list, true);
				var i_am = ds_list_find_index(player_list, player_id);
				if(i_am >= 0 and i_am < session_players) { // if greater, then is a spectator
					player_number = i_am;
					player_inst = scr_spawn_player(player_number); // spawn player
					ds_list_replace(instance_list, player_number, player_inst);
				}
				
				ds_list_clear(frame_list);
				game_state = GAMESTATE.resync;
			}
			else {
				frame_time_next = get_timer() + 500000; // try again in half a second
				break;
			}
		
		case GAMESTATE.resync:
			// Resynchronization: this is intended for recieving a full state update
			// if desync-detection is implemented, it should re-enter this state to re-sync players
			
			debug_text = "Frame " + string(frame_number) + " resync";
			show_debug_message(debug_text);
			
			// send myself and n frames into the future
			var buff = protobuild_buffer("player_sync")
			protobuild_encode_direct(buff, "player_sync", player_id, frame_number, player_inst.x, player_inst.y, 0, 0);
			netcode_relay_tx(buff);
			netcode_relay_rx(buff);
			buffer_delete(buff);
			
			scr_send_inputs();
			
			if(ds_list_size(frame_list) >= session_players) {
				ds_list_clear(frame_list);
				game_state = GAMESTATE.go;
				frame_time_next = get_timer(); // reset next timer
			}
			else {	
				frame_time_next = get_timer() + 500000; // try again in half a second
				break;
			}
			
		case GAMESTATE.go:
			// main  game state.
			
			debug_text = ""
			
			// check we have all inputs for this frame
			var num_inputs = scr_check_inputs(frame_number)
			
			// check if we need to update the simulation and advance frame numbers
			if(predict_number and (is_undefined(predict_last_inputs) or  num_inputs > predict_last_inputs)) {
				debug_text = "Rollback to " + string(frame_number) + " and fast-forward to " + string(frame_number + predict_number) + " "
				show_debug_message(debug_text);
					
				predict_last_inputs = num_inputs;
					
				// rollback for players
				with(obj_player) {
					event_user(PLAYEREVENTS.rollback_restore);
				}
					
				// re-simulate forward with real inputs until we run out of frames
				while(predict_number > 0) {
					if(num_inputs == session_players) {
						show_debug_message("Resimulate " + string(frame_number))
						with(obj_player) {
							current_frame = other.frame_number;
							event_user(PLAYEREVENTS.lockstep_input);
							steps_to_run = other.frame_skip + 1;
						}
						frame_number += 1;
						global.stats_frames += 1;
						predict_number -= 1;
					}
					else {
						break;
					}
					num_inputs = scr_check_inputs(frame_number);
					predict_last_inputs = num_inputs;
				}
					
				// any remaining frames, save and use predictions
				if(predict_number > 0) {
					with(obj_player) {
						event_user(PLAYEREVENTS.rollback_save);
					}
					for(var virtual_frame=frame_number; virtual_frame<frame_number+predict_number; virtual_frame++) {
						show_debug_message("Predict " + string(virtual_frame))
						with(obj_player) {
							current_frame = virtual_frame;
							event_user(PLAYEREVENTS.lockstep_predict);
							steps_to_run = other.frame_skip + 1;
						}
					}
				}
				
			}
			
			var lag = false;
			// do we have all the inputs for this frame?
			if(num_inputs == session_players) {
				debug_text += "Frame " + string(frame_number) + " normal";
				show_debug_message(debug_text)
					
				// perform for regular frame for all players
				with(obj_player) {
					current_frame = other.frame_number;
					event_user(PLAYEREVENTS.lockstep_input);
					steps_to_run = other.frame_skip + 1;
				}
				frame_number += 1;
				global.stats_frames += 1;
				predict_last_inputs = undefined;
			}
			else if(predict_number < predict_max) { // if not, we have to predict
				debug_text += "Frame " + string(frame_number) + " predict " + string(frame_number + predict_number)
				show_debug_message(debug_text);
				
				predict_last_inputs = num_inputs;
				
				if(predict_number == 0) { // first prediction frame, set prediction states
					with(obj_player) {
						event_user(PLAYEREVENTS.rollback_save);
					}
				}
				
				// Prediction step for players
				with(obj_player) {
					current_frame = other.frame_number+other.predict_number;
					event_user(PLAYEREVENTS.lockstep_predict);
					steps_to_run = other.frame_skip + 1;
				}
				predict_number += 1;
				global.stats_predict += 1;
			}
			else { // otherwise, we have to lag
				global.stats_wait += 1;
				debug_text = "Frame " + string(frame_number) + " lag";
				show_debug_message(debug_text);
				lag = true;
				frame_time_next = get_timer() // reset frame_time_next
			}
			
			// set up next frame
			frame_time_next += 1000000*(frame_skip + 1)/room_speed; // schedule for next frame
			
			// get inputs
			if(lag == false) { // not lagged, new step, grab input
				// get new frame input
				var frame = frame_number+predict_number+input_delay;
				scr_collect_inputs(frame)
				if(frame % (ping_skip + 1) == 0) {
					scr_send_ping(frame);
				}
			}
				
			// frame tracking
			var buffer_left = input_latest_frame - frame_number;
			show_debug_message("Buffer: "+string(buffer_left)+" ahead");
			if(buffer_left < 0) { // slow down if ahead by too much
				show_debug_message("Track --");
				frame_time_next += 0.2*1000000*(frame_skip + 1)/room_speed
			}
			debug_text += " Buffer: " + string(buffer_left) + " ahead";
				
			// send inputs
			scr_send_inputs();
			
			// debug display pings
			debug_text2 = ""
			for(var i=0; i<ds_list_size(ping_list); i++) {
				var ping = ds_list_find_value(ping_list, i);
				
				if(not is_undefined(ping)) {
					debug_text2 += "PLAYER" + string(i+1) + " PING " + string_format(ping, 0, 0) + "ms; ";
				}
			}
			
			break;
			
		case GAMESTATE.finished:
			// end state
			debug_text = "Frame " + string(frame_number) + " finished";
			show_debug_message(debug_text);
			frame_time_next = get_timer() + 1000000*(other.frame_skip + 1)/room_speed;
			break;
	}
}
else {
	debug_text += ".";	
}
