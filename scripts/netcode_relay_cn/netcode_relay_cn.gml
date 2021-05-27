/// @description  Callback for connection established to relay
function netcode_relay_cn() {

	with(obj_connection) {
		if(conn_state == STATE.relay_connecting) {
			conn_state = STATE.relay_connected;
			show_debug_message("Server Connected")
			
			// TODO: (RN) need some kind of response from 
			// the server before moving into the rm_mp_game?
			if(room != rm_mp_game) {
				room_goto(rm_mp_game);
			}
		}
	}


}
