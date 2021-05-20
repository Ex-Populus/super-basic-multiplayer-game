/// @description object for doing network connection

#region SINGLETON_PATTERN
	if(instance_number(object_index) > 1) {
	    if(debug_mode) {
	        show_error("More than one "+object_get_name(object_index)+" exists in "+room_get_name(room), true);
	    }
	    else {
	        instance_destroy();
	        exit;
	    }
	}
#endregion SINGLETON_PATTERN

#region CONFIG
	network_set_config(network_config_use_non_blocking_socket, 1);
	network_set_config(network_config_connect_timeout, 4000);
#endregion CONFIG

#region PACKET_STATS
	global.stats_wait = 0;
	global.stats_predict = 0;
	global.stats_frames = 0;
	packet_timer = 0;
	packet_stat = "";
#endregion PACKET_STATS

socket_list = ds_list_create();

// connection state machine, probably more complex than necessary, but does keep thing sclean
enum STATE {
	relay_connect,
	relay_connecting,
	relay_connected,
	finished_hang
}

conn_state = STATE.relay_connect;
debug_text = "Undefined";
//server_addr = "35.196.130.86";
server_addr = "127.0.0.1";
server_port = 11000
server_socket = undefined;
