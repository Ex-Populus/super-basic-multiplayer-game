/// @description read inputs

var kFire = (keyboard_check(vk_space) || mouse_check_button(mb_left));
var kRight = (keyboard_check(vk_right) || keyboard_check(ord("D")));
var kLeft = (keyboard_check(vk_left) || keyboard_check(ord("A")));
var kUp = (keyboard_check(vk_up) || keyboard_check(ord("W")));
var kDown = (keyboard_check(vk_down) || keyboard_check(ord("S")));

input_hin = (kRight - kLeft) * moveSpeed;
input_vin = (kUp - kDown) * moveSpeed;
input_fire = kFire;