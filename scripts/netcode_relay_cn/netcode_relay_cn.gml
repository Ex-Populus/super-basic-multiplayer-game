/// @description  Callback for connection established to relay
function netcode_relay_cn() {

	with(obj_connection) {
		if(conn_state == STATE.relay_connecting) {
			conn_state = STATE.relay_connected;
			show_debug_message("Server Connected")
			//if(room != rm_staging) {
			//	room_goto(rm_staging);
			//}
		}
	}


}
