/// @description  Add a value to a protobuild message
/// @argument     msg_name - name of new message
/// @argument     *callback - function index of callback handler to trigger when recieving this message
function protobuild_msg_add_value(argument0, argument1, argument2, argument3) {

	var msg_name = string(argument0);
	var val_name = string(argument1);
	var val_type = argument2;
	var val_default = argument3;

	var msg = ds_map_find_value(global.protobuild_msg_spec, msg_name);
	if(is_undefined(msg)) {
		show_error("ERROR: message " + string(msg_name) + " does not exist", true);
	}
	else {
		var types = ds_map_find_value(msg, "types");
		ds_list_add(types, val_type);
	
		var spec = ds_map_find_value(msg, "spec");
	
		// check for existing
		for(var i=0; i<ds_list_size(spec); i++) {
			var check_val = ds_list_find_value(spec, i);
			if(ds_map_find_value(check_val, "name") == val_name) {
				show_error("ERROR: value " + string(val_name) + " in " + string(msg_name) + " already exists", true);	
			}
		}
	
		// create and add
		var add_val = ds_map_create();
		ds_map_add(add_val, "name", val_name)
		ds_map_add(add_val, "type", val_type)
		ds_map_add(add_val, "default", val_default)
	
		var values = ds_map_find_value(msg, "values");
		ds_map_replace(msg, "values", values+1);
	
		ds_list_add(spec, add_val);
		ds_list_mark_as_map(spec, ds_list_size(spec)-1);
	
		// calculate size
		var size = ds_map_find_value(msg, "size");
		switch(val_type) {
			case PROTOBUILD_TYPE.boolean:
			case PROTOBUILD_TYPE.u8:
			case PROTOBUILD_TYPE.s8:
				size += 1;
				break;
			case PROTOBUILD_TYPE.u16:
			case PROTOBUILD_TYPE.s16:
				size += 2;
				break;
			case PROTOBUILD_TYPE.u32:
			case PROTOBUILD_TYPE.s32:
			case PROTOBUILD_TYPE.f32:
				size += 4;
				break;
			case PROTOBUILD_TYPE.u64:
			case PROTOBUILD_TYPE.f64:
				size += 8;
				break;
			case 0:
				show_error("ERROR: cannot have zero-length for value " + string(val_name) + " in " + string(msg_name), true)
				break;
			default:
				if(val_type >= PROTOBUILD_TYPE.last) {
					show_error("ERROR: string too long (" + string(val_type) + ") for value " + string(val_name) + " in " + string(msg_name), true)
				}
				size += val_type;
		}
		ds_map_replace(msg, "size", size);
	}

}
