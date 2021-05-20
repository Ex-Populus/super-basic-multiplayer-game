/// @description  Imports a protobuild spec from a json file
/// @argument     code - header code
/// @argument     file - file containing the spec
function protobuild_import(argument0, argument1) {

	global.protobuild_code = argument0;
	var export_name = string(argument1);

	// read file
	var buff = buffer_load(export_name);
	var load_str = buffer_read(buff, buffer_text);
	global.protobuild_msg_spec = json_decode(load_str);

	if(global.protobuild_msg_spec == -1) {
		show_error("ERROR: could not import " + string(export_name), true);
	}

	// rebuild index
	global.protobuild_msg_index = ds_list_create();

	var key = ds_map_find_first(global.protobuild_msg_spec);
	while(not is_undefined(key)) { 
		var msg_map = ds_map_find_value(global.protobuild_msg_spec, key);
	
		// get id number
		var msg_id = ds_map_find_value(msg_map, "id");
		ds_list_set(global.protobuild_msg_index, msg_id, msg_map);
	
		// update script name
		var callback_str = ds_map_find_value(msg_map, "callback_str");
		if(not is_undefined(callback_str)) {
			ds_map_replace(msg_map, "callback", asset_get_index(callback_str))
		}
		else {
			ds_map_replace(msg_map, "callback", noone);	
		}
		key = ds_map_find_next(global.protobuild_msg_spec, key);
	}

	// cleanup
	buffer_delete(buff);

}
