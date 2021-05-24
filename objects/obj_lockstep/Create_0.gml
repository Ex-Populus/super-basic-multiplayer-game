/// @description init

#region SINGLETON PATTERN
	if(instance_number(object_index) > 1) {
	    if(debug_mode) {
	        show_error("More than one "+object_get_name(object_index)+" exists in "+room_get_name(room), true);
	    }
	    else {
	        instance_destroy();
	        exit;
	    }
	}
#endregion SINGLETON PATTERN

#region GAME STATE MACHINE
enum GAMESTATE {
	registering,
	resync,
	go,
	finished
}

game_state = GAMESTATE.registering
debug_text = "Registration"
debug_text2 = ""

player_id = irandom(0x7FFFFFFF); // random player ID
show_debug_message("player_id assigned " + string(player_id));
player_list = ds_list_create(); // list of registered players (their index represents the player number)
instance_list = ds_list_create(); // list of matching player instances
frame_list = ds_list_create(); // list of recieved data for the frame (used for lockstep)
stat_list = ds_list_create(); // list of known frames for other players
ping_list = ds_list_create(); // list of pings for other players

player_number = undefined;
player_inst = undefined;

#endregion GAME STATE MACHINE

#region LOCKSTEP SETUP
// TODO: (RN) Change session_players back to 2 after debugging is complete!
//session_players = 2; // number of players in this session
session_players = 1; // number of players in this session

frame_number = 0; // initial frame number, always 0
frame_skip = 2; // finds ratio of game frames to room speed.  frame_skip+1/room_speed is the real rate
frame_time_next = get_timer(); // used to keep track of next frame to execute, this is delta_time-like

ping_skip = 1; // how many frames to skip per ping.  ping_skip+1 is the real number
ping_seq = ds_priority_create(); // ping sequence validation, this is used to ensure ping is real

input_history = ds_priority_create(); // input history buffer for sending
input_delay = 2; // number of frames input delay. (input_delay+1)*(frame_skip+1)/room_speed is the real delay time
input_latest_frame = 0; // latest recieved frame, always init to 0

predict_number = 0; // prediciton number, always init to 0
predict_max = 5; // maximum number of prediction frames. (predict_max)*(frame_skip+1)/room_speed is the real max prediction time
predict_last_inputs = undefined; // number of inputs last time the prediction was ran, always init to undefined
#endregion

for(var i=0; i<=input_delay; i++) { // load up initial input history
	scr_collect_inputs(i, true)
}