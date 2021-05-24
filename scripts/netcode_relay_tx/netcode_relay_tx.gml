/// @description  Transmit buffer
/// @argument     buff - buffer index for data to transmit
function netcode_relay_tx(argument0) {

	var buff = argument0;

	with(obj_connection) {
		network_send_raw(server_socket, buff, buffer_get_size(buff));
		show_debug_message("TX: " + string(buffer_get_size(buff)) + " bytes");
	}

}
