/// @function handle_client_connect(async_load_map, sockets);
/// @param {map} async_load_map The async_load map object for the event
/// @param {list} sockets The server's list of client sockets

function scr_server_client_cn(_async_load_map, _sockets){
	var socket = ds_map_find_value(_async_load_map, "socket");
	ds_list_add(_sockets, socket);
	
	// TODO: (RN) Send a cnx ack back to client here?
	// What is the essage format for that?
	
	return ds_map_find_value(_async_load_map, "id");
}