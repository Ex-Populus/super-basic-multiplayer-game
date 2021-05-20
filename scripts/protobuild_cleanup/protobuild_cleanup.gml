/// @description  Clean up maps and stuff that are used by protobuild
function protobuild_cleanup() {

	ds_map_destroy(global.protobuild_msg_spec);
	ds_map_destroy(global.protobuild_msg_index);

}
