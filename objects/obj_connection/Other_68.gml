/// @description RX data

var eventid = async_load[? "id"];
var type = async_load[? "type"];

// hub connection stuff
var socket_map = ds_list_find_value(socket_list, eventid) 
if(not is_undefined(socket_map)) {
	
	switch(type) {
		case network_type_connect:
		case network_type_non_blocking_connect:
			if(async_load[? "succeeded"] == 1) {
				var script = ds_map_find_value(socket_map, "callback_c_ok");
				if(script_exists(script)) script_execute(script);
				ds_map_replace(socket_map, "connected", true);
			}
			else {
				var script = ds_map_find_value(socket_map, "callback_c_fail");
				if(script_exists(script)) script_execute(script);	
				ds_map_replace(socket_map, "connected", false);
			}
			break;
			
		case network_type_disconnect:
			var script = ds_map_find_value(socket_map, "callback_dc");
			if(script_exists(socket_map)) script_execute(script);
			ds_map_replace(socket_map, "connected", false);
			break;
			
		case network_type_data:
			var script = ds_map_find_value(socket_map, "callback_rx");
			if(script_exists(socket_map)) script_execute(script, async_load[? "buffer"], async_load[? "size"]);
			break;
	}
	
}