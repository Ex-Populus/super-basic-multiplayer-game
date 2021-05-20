/// @description  Send a ping
/// @argument     frame - current frame to send ping for
function scr_send_ping(argument0) {

	var frame = argument0;

	with(obj_lockstep) {
		var buff = protobuild_buffer("ping")
		var time = floor(get_timer()/1000);
		protobuild_encode_direct(buff, "ping", player_id, frame, time);
		with(obj_lockstep) {
			ds_priority_add(ping_seq, time, time);
		}

		netcode_relay_tx(buff);
		buffer_delete(buff);
	}

}
