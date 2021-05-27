/// @function scr_server_client_data(async_load_map, sockets);
/// @param {map} async_load_map The async_load map object for the event
/// @param {list} sockets The server's list of client sockets

function scr_server_client_data(_async_load_map, _sockets){
	var socket = ds_map_find_value(_async_load_map, "socket");
	var buffer = ds_map_find_value(_async_load_map, "buffer");
	
	var counter = 0;
	for (var i = 0; i < ds_list_size(_sockets) - 1; i++) {
		if (socket == _sockets[i]) {
			// skip if buffer data came from this client
			continue;
		}
		
		// send buffer data to all other clients
		network_send_packet(_sockets[i], buffer, buffer_tell(buffer));
		
		counter += 1;
	}
	
	return counter;
}