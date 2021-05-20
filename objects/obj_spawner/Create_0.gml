/// @description Insert description here

players = ds_list_create();
playersInfo = ds_list_create();

var centerY = room_height / 2;
var centerX = room_width / 2;
var offsetX = centerX / 2;

var ary = [
	{
		name: "Player 1",
		colorPlayer: c_lime,
		colorFire: c_fuchsia,
		x: (centerX - offsetX),
		y: centerY,
	},
	{
		name: "Player 2",
		colorPlayer: c_aqua,
		colorFire: c_orange,
		x: (centerX + offsetX),
		y: centerY,
	},
];

for (var i = 0; i < array_length_1d(ary); i++) {
	ds_list_add(playersInfo, ary[i]);
}

// spawn a player by default in sp room
if (room == rm_sp_game) {
 scr_spawn_player();
}
