/// @description  Exports a protobuild spec to a json file
/// @argument     file - file name to export to
function protobuild_export(argument0) {

	var export_name = string(argument0);

	// write and save buffer
	var export_str = json_encode(global.protobuild_msg_spec);
	var buff = buffer_create(string_byte_length(export_str), buffer_fixed, 1);
	buffer_write(buff, buffer_text, export_str);
	buffer_save(buff, export_name);

	// cleanup
	buffer_delete(buff);

}
