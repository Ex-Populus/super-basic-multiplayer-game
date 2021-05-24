function scr_init() {
	randomize();

#region BUILD_PROTOCOL

	// This is the protocol header, it uniquely identifies this protocol,
	// it can be anything, but all clients expected to talk to each other must have the same header
	protobuild_new(0x474D);

	// Registration message, used for player registration
	protobuild_add_msg("registration", scr_cb_registration);
	protobuild_msg_add_value("registration", "id", PROTOBUILD_TYPE.u32, 0);

	// Sync message, this is intended for use to fully re-sync player state
	protobuild_add_msg("player_sync", scr_cb_player_sync);
	protobuild_msg_add_value("player_sync", "id", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("player_sync", "frame", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("player_sync", "x", PROTOBUILD_TYPE.f32, 0);
	protobuild_msg_add_value("player_sync", "y", PROTOBUILD_TYPE.f32, 0);
	protobuild_msg_add_value("player_sync", "hp", PROTOBUILD_TYPE.u16, 0);
	protobuild_msg_add_value("player_sync", "effects", PROTOBUILD_TYPE.u16, 0);

	// This is the workhorse message behind deterministic lockstep, it is the player's input
	protobuild_add_msg("player_input", scr_cb_player_input);
	protobuild_msg_add_value("player_input", "id", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("player_input", "frame", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("player_input", "hin", PROTOBUILD_TYPE.s8, 0);
	protobuild_msg_add_value("player_input", "buttons", PROTOBUILD_TYPE.u8, 0);
	protobuild_msg_add_value("player_input", "aim", PROTOBUILD_TYPE.u16, 0);

	// Ping message
	protobuild_add_msg("ping", scr_cb_ping);
	protobuild_msg_add_value("ping", "from", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("ping", "frame", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("ping", "time", PROTOBUILD_TYPE.u32, 0);

	// Repyl to ping
	protobuild_add_msg("pong", scr_cb_pong);
	protobuild_msg_add_value("pong", "from", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("pong", "to", PROTOBUILD_TYPE.u32, 0);
	protobuild_msg_add_value("pong", "time", PROTOBUILD_TYPE.u32, 0);

#endregion BUILD_PROTOCOL

	// Some game constants
	global.gravity = 0.8;

	// Go to room
	room_goto(rm_lobby);
}
