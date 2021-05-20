/// @description  INTERNAL FUNCTION Decode a value from bufer
/// @argument     buff - index of buffer to decode
/// @argument     spec_type - type of buffer to read
function protobuild_decode_value(argument0, argument1) {

	var buff = argument0;
	var spec_type = argument1;

	var value = undefined;
	switch(spec_type) {
		case PROTOBUILD_TYPE.boolean:
		case PROTOBUILD_TYPE.u8:
			value = buffer_read(buff, buffer_u8);
			break;
		case PROTOBUILD_TYPE.s8:
			value = buffer_read(buff, buffer_s8);
			break;
		case PROTOBUILD_TYPE.u16:
			value = buffer_read(buff, buffer_u16);
			break;
		case PROTOBUILD_TYPE.s16:
			value = buffer_read(buff, buffer_s16);
			break;
		case PROTOBUILD_TYPE.u32:
			value = buffer_read(buff, buffer_u32);
			break;
		case PROTOBUILD_TYPE.s32:
			value = buffer_read(buff, buffer_s32);
			break;
		case PROTOBUILD_TYPE.f32:
			value = buffer_read(buff, buffer_f32);
			break;
		case PROTOBUILD_TYPE.u64:
			value = buffer_read(buff, buffer_u64);
			break;
		case PROTOBUILD_TYPE.f64:
			value = buffer_read(buff, buffer_f64);
			break;
		default:
			var tmp_buff = buffer_create(spec_type, buffer_u8, 1)
			var tell = buffer_tell(buff);
			buffer_copy(buff, tell, spec_type, tmp_buff, 0);
			buffer_seek(buff, buffer_seek_start, tell + spec_type);
				
			value = buffer_read(tmp_buff, buffer_text);
			buffer_delete(tmp_buff);
	}

	return value;

}
