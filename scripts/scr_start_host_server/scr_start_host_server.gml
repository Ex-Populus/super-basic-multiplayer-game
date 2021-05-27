// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_start_host_server(){
	with (obj_server) {
		startServer = true;
	}
	
	with (obj_connection) {
		server_addr = "127.0.0.1"; // self-hosting
	}
	
	// TODO: (RN) need to wait for the
	// second player before going to rm_mp_game
	//scr_goto_mp_game();
}