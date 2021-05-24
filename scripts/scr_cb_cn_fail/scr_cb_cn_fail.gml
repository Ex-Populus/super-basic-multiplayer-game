// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_cb_cn_fail() {
	var msg = "FAILED TO CONNECT TO SERVER!";
	show_debug_message(msg);
	throw msg;
}