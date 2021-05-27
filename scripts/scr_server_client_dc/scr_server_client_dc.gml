/// @function handle_client_disconnect(async_load_map, sockets);
/// @param {map} async_load_map The async_load map object for the event
/// @param {list} sockets The server's list of client sockets

function scr_server_client_dc(_async_load_map, _sockets){
	ds_list_delete(_sockets, ds_map_find_value(_async_load_map, "socket"));

	return ds_map_find_value(_async_load_map, "id");
}