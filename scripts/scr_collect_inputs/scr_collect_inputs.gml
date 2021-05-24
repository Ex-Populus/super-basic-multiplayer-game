/// @description  Collect inputs from player and add to input history buffer
/// @argument     frame - input frame to use
/// @argument     *zero - whether to use zero data (usually only used for initialization)
function scr_collect_inputs() {

	if(argument_count < 1) {
		show_error("Invalid argument count", true);	
	}

	var frame = argument[0];
	var zero = (argument_count > 1) 
		? argument[1]
		: false;

	var input_map = ds_map_create()
	ds_map_add(input_map, "id", player_id);
	ds_map_add(input_map, "frame", frame);

	if(zero == false) {
		// grab input
		with(obj_input) {
			event_user(0);
			ds_map_add(input_map, "hin", latch_hin);
			ds_map_add(input_map, "buttons", latch_buttons);
			ds_map_add(input_map, "aim", latch_aim);
		}
	}

	// add to priorty list
	ds_priority_add(input_history, input_map, frame);

	// send direct to self via map (bypass buffer entirely)
	//netcode_player_input(input_map);

}
