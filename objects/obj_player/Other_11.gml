/// @description lockstep input prediction

while(steps_to_run) { // run out any steps left to run
	event_perform(ev_step, 0);
}

var buff_map = ds_priority_find_min(rollback_input_buffer);
var pri = ds_priority_find_priority(rollback_input_buffer, buff_map);

if(pri == current_frame) { // if input has current frame, use it
	use_hin = ds_list_find_value(buff_map, 0);
	use_vin = ds_list_find_value(buff_map, 1);
	use_fire = ds_list_find_value(buff_map, 2);
	ds_priority_delete_min(rollback_input_buffer);
	
	debug_text = "+";
	debug_color = c_green
}
else { // otherwise use prediction
	use_hin = use_hin;
	use_vin = use_vin;
	use_fire = 0;
	
	debug_text = "!";
	debug_color = c_blue
}

if (use_hin == 0) {
	debug_text += "-";
} else {
	debug_text += use_hin > 0 ? ">" : "<";
}

if (use_vin == 0) {
	debug_text += "-";
} else {
	debug_text += use_vin > 0 ? "^" : "v";
}

if (use_fire) {
	debug_text += "X";
} else {
	debug_text += "-";
}