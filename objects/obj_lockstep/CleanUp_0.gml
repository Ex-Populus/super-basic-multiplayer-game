/// @description clean up datastructures

ds_list_destroy(player_list);
ds_list_destroy(instance_list);
ds_list_destroy(frame_list);
ds_list_destroy(stat_list);
ds_list_destroy(ping_list);
ds_priority_destroy(ping_seq);
ds_priority_destroy(input_history);