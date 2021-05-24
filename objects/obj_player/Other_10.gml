/// @description lockstep input control

while(steps_to_run) { // run out any steps left to run
	event_perform(ev_step, 0);	
}
					
var buff_map = ds_priority_delete_min(input_buffer);

use_hin = ds_list_find_value(buff_map, 0);
use_vin = ds_list_find_value(buff_map, 1);
use_fire = ds_list_find_value(buff_map, 2);

ds_list_destroy(buff_map);

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

debug_color = c_white;
