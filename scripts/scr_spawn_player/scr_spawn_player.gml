/// @description  Spawn player at either a spawn point, or a random location in the room
/// @argument     *number - optional player number
/// @return       returns instance number of spawned player
function scr_spawn_player() {

	if (!instance_exists(obj_spawner)) {
		var errorMessage = "Missing obj_spawner when trying to spawn player in room " + room_get_name(room) + "!";
		throw errorMessage;
	}

	// if spawner exists on the map with player info
	with(obj_spawner) {
		// do nothing if player info list is empty
		if (ds_list_size(playersInfo) < 1) {
			show_debug_message("### [WARN] ==> Empty playersInfo! - " + string(ds_list_size(playersInfo)));
			return;
		}
		
		// assign a player number based on the current player count
		var playerNumber = ds_list_size(players) + 1;
		
		// ... but use a number if one was passed in
		if (argument_count == 1) {
			playerNumber = argument0;
		}

		// find the next player info from the list
		var playerInfo = ds_list_find_value(playersInfo, 0);

		// create a new player instance with player info
		var inst = instance_create_layer(playerInfo.x, playerInfo.y, "Players", obj_player)
		inst.player_number = playerNumber;
		inst.playerName = playerInfo.name;
		inst.colorPlayer = playerInfo.colorPlayer;
		inst.colorFire = playerInfo.colorFire;

		// remove player info so they can only be spawned once per room
		ds_list_delete(playersInfo, 0);
		
		// add new player instance to spawner players list
		ds_list_add(players, inst);
		
		show_debug_message("### ==> [DEBUG] Player " + string(playerNumber) + " created!");

		return inst;
	}

}
