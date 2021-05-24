/// @description create event

playerName = "Player ?";
playerColors = [c_lime, c_fuchsia];
colorPlayer = playerColors[(instance_number(object_index) - 1) || 0];
colorFire = c_red;

moveSpeed = 7;
fire = false;

// ################

state_variables = ["x", "y", "fire" ]

player_number = undefined;

input_buffer = ds_priority_create();
rollback_input_buffer = ds_priority_create();
rollback_state = ds_map_create();

use_hin = 0;
use_vin = 0
use_fire = 0;

enum PLAYEREVENTS {
	lockstep_input=0,
	lockstep_predict,
	rollback_save,
	rollback_restore
}

steps_to_run = 0;
current_frame = 0;


debug_text = "DEBUG";
debug_color = c_white;
