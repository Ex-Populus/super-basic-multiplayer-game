/// @description  Create a new protocol message
/// @argument     msg_name - name of new message
/// @argument     *callback - function index of callback handler to trigger when recieving this message
function protobuild_add_msg() {

	if(argument_count < 1) {
		show_error("Invalid argument count", true);
	}

	var msg_name = string(argument[0]);
	var callback = noone;
	var callback_str = undefined;
	if(argument_count > 1) {
		callback = argument[1];	
		callback_str = script_get_name(callback);
	}


	// check if it exists
	var find = ds_map_find_value(global.protobuild_msg_spec, msg_name);
	if(is_undefined(find)) {
		// add keys
		var new_msg = ds_map_create();
		ds_map_add_list(new_msg, "spec", ds_list_create());
		ds_map_add_list(new_msg, "types", ds_list_create());
		ds_map_add(new_msg, "size", 0);
		ds_map_add(new_msg, "values", 0);
		ds_map_add(new_msg, "id", ds_map_size(global.protobuild_msg_spec));
		ds_map_add(new_msg, "callback", callback);
		ds_map_add(new_msg, "callback_str", callback_str);
		ds_map_add_map(global.protobuild_msg_spec, msg_name, new_msg);
	
		ds_list_add(global.protobuild_msg_index, new_msg); // deliberately don't mark as map, no need
	}
	else {
		show_error("ERROR: message " + string(msg_name) + " was already added", true);	
	}

}
