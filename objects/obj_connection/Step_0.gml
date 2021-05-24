/// @description connecion state machine

switch(conn_state) {
	case STATE.relay_connect:
		debug_text = "Initialize server connection..."
	
		server_socket = netcode_create_connection(server_addr, server_port, network_socket_udp, netcode_relay_rx, netcode_relay_cn, netcode_relay_dc, scr_cb_cn_fail);
		show_debug_message("Starting new connection to " + server_addr + ":" + string(server_port))
		conn_state = STATE.relay_connecting;
		
		// fallthrough
		
	case STATE.relay_connecting:
		debug_text = "Connecting to server..."
		break
		
	case STATE.relay_connected:
		debug_text = "Connected"
		debug_text += " (" + string(room_speed)
		debug_text += ", " + string(packet_timer)
		debug_text += ")"
		
		// packet stats
		packet_timer += 1;
		if(packet_timer >= room_speed) {
			packet_stat = " FRAMES: " + string(global.stats_frames)
			packet_stat += " PREDICT: " + string(global.stats_predict)
			packet_stat += " WAIT: " + string(global.stats_wait)
			packet_timer = 0;
		}
		debug_text += packet_stat;
		break
		
	case STATE.finished_hang:
		debug_text = "Disconnected"
}