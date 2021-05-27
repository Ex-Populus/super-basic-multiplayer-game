/// @description 

switch (serverState) {
	case SERVER_STATE.idle:
		if (startServer) {
			show_debug_message("SERVER: changing from idle to starting...");
			serverState = SERVER_STATE.starting;
		} else {
			debug_text = "SERVER: idle...";
		}
		break;
	
	case SERVER_STATE.starting:
		server = network_create_server(network_socket_udp, port, max_clients);

		if (server < 0) {
			show_debug_message("SERVER: failed to start (" + server + ")");
			startServer = false;
			serverState = SERVER_STATE.idle;
		} else {
			show_debug_message("SERVER: started on port " + string(port));
			serverState = SERVER_STATE.running;
		}
		break;
		
	case SERVER_STATE.running:
		debug_text = "SERVER: running on port " + string(port);
		break;
}

debug_text += " ";
debug_text += "(";
debug_text += "sockets: " + string(ds_list_size(sockets));
debug_text += ", ";
debug_text += "packets: " + string(packetsCount);
debug_text += ")";
