/// @description init

#region SINGLETON_PATTERN
	if(instance_number(object_index) > 1) {
	  if(debug_mode) {
			show_error("More than one " + object_get_name(object_index) + " exists in " + room_get_name(room), true);
	  } else {
			instance_destroy();
	    exit;
	  }
	}
#endregion SINGLETON_PATTERN


latch_hin = 0;
latch_vin = 0;
latch_fire = 0;

input_hin = 0;
input_vin = 0;
input_fire = 0;

debug_text = "Input: "
