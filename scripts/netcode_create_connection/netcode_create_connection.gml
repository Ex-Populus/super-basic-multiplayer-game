/// @description  Creates a new network connection and registers callbacks
/// @argument     addr - host address
/// @argument     port - host port
/// @argument     type - socket type
/// @argument     *callback_rx - Callback for recieving data
/// @argument     *callback_c_ok - Callback for connection established
/// @argument     *callback_dc -  Callback for disconnect
/// @argument     *callback_c_fail - Callback for connection fail
function netcode_create_connection() {

	var addr = undefined;
	var port = undefined;
	var type = undefined;
	var callback_rx = undefined;
	var callback_c_ok = undefined;
	var callback_dc = undefined;
	var callback_c_fail = undefined;

	if(argument_count > 2) {
		addr = argument[0];
		port = argument[1];
		type = argument[2];
	}
	else {
		show_error("Invalid argumnet count", true);	
	}
	if(argument_count > 3) callback_rx = argument[3]
	if(argument_count > 4) callback_c_ok = argument[4];
	if(argument_count > 5) callback_dc = argument[5];
	if(argument_count > 6) callback_c_fail = argument[6];	

	with(obj_connection) {
		var socket = network_create_socket(type);
		network_connect_raw(socket, addr, port);
	
		var map = ds_map_create()
		ds_map_add(map, "addr", addr);
		ds_map_add(map, "port", port);
		ds_map_add(map, "type", type);
		ds_map_add(map, "socket", socket);
		ds_map_add(map, "callback_rx", callback_rx);
		ds_map_add(map, "callback_c_ok", callback_c_ok);
		ds_map_add(map, "callback_dc", callback_dc);
		ds_map_add(map, "callback_c_fail", callback_c_fail);
		ds_map_add(map, "connected", false);
	
		// fill socket list with undefines if smaller than size
		for(var i=ds_list_size(socket_list); i<socket; i++) {
			ds_list_set(socket_list, i, undefined);
		}
	
		ds_list_set(socket_list, socket, map);
		ds_list_mark_as_map(socket_list, socket);
	
		return socket;
	}

}
