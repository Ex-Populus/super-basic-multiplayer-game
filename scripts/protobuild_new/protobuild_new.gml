/// @description  Create a new protocol
/// @argument     code - header value for protocol
function protobuild_new(argument0) {

	// create clobal structures
	global.protobuild_code = argument0;
	global.protobuild_msg_spec = ds_map_create();
	global.protobuild_msg_index = ds_list_create();

	enum PROTOBUILD_TYPE {
		boolean=0xFFF0,
		u8,
		u16,
		u32,
		u64,
		s8,
		s16,
		s32,
		f32,
		f64,
		last
	}

}
