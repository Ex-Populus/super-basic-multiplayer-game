/// @description rollback save and enter predicted state

while(steps_to_run) { // run out any steps left to run
	event_perform(ev_step, 0);	
}

// clear rollback state
ds_map_clear(rollback_state);

// copy state variables
for(var i=0; i<array_length_1d(state_variables); i++) {
	var name = state_variables[i];
	var value = variable_instance_get(id, name);
	ds_map_add(rollback_state, name, value);
}

// duplicate input buffer (implicitly cleared by ds_priority_copy)
ds_priority_copy(rollback_input_buffer, input_buffer);