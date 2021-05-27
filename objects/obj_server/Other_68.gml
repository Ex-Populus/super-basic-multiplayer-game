/// @description State machine

type = ds_map_find_value(async_load, "type");

switch(type) {
	
	case network_type_connect:
		var clientId = scr_server_client_cn(async_load, sockets);
		show_debug_message("SERVER: client id " + string(clientId) + " connected (" + string(ds_list_size(sockets)) + ")");
		break;
		
	case network_type_disconnect:
		var clientId = scr_server_client_dc(async_load, sockets);
		show_debug_message("SERVER: client " + string(clientId) + " disconnected");
		break;
		
	case network_type_data:
		var count = scr_server_client_data(async_load, sockets);
		show_debug_message("SERVER: data received, " + string(count) + " clients notified");
		break;
		
	default:
		show_debug_message("SERVER: =====> !! UNKNOWN ASYNC LOAD TYPE - " + string(type));
	
}