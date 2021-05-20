/// @description  Callback function for netcode registration message.  It handles registering other players
/// @argument     msg_map - input map containing registration details
function scr_cb_registration(argument0) {

	var msg_map = argument0;

	var other_id = ds_map_find_value(msg_map, "id")

	show_debug_message("MSG: Register id " + string(other_id));
	if(not is_undefined(other_id)) {
		with(obj_lockstep) {
			if(ds_list_find_index(player_list, other_id) < 0) {
				show_debug_message("Registering " + string(other_id));
				ds_list_add(player_list, other_id);
				ds_list_add(instance_list, noone);
				ds_list_add(ping_list, undefined);
				ds_list_add(stat_list, undefined);
			}
		}
	}

}
