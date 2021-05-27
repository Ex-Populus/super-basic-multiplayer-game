/// @description Setup server

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

enum SERVER_STATE {
	idle,
	starting,
	running,
}
serverState = SERVER_STATE.idle;

startServer = false;

port = 11000;
max_clients = 2;

server = undefined;
sockets = ds_list_create();
packetsCount = 0;

debug_text = "";
