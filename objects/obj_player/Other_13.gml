/// @description rollback restore

// restore state variables
for(var i = 0; i < array_length_1d(state_variables); i++) {
	var name = state_variables[i];
	var value = ds_map_find_value(rollback_state, name);
	variable_instance_set(id, name, value);
}