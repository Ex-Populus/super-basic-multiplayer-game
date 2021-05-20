/// @description  Callback for disconnect from relay
function netcode_relay_dc() {

	with(obj_connection) {
		conn_state = STATE.finished_hang;
		show_debug_message("Server Disconnected");
	}

}
