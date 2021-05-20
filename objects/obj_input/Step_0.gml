/// @description read inputs

var kFire = (keyboard_check(vk_space) || mouse_check_button(mb_left));
var kRight = (keyboard_check(vk_right) || keyboard_check(ord("D")));
var kLeft = (keyboard_check(vk_left) || keyboard_check(ord("A")));
var kUp = (keyboard_check(vk_up) || keyboard_check(ord("W")));
var kDown = (keyboard_check(vk_down) || keyboard_check(ord("S")));

input_hin = (kRight - kLeft) * moveSpeed;
input_vin = (kUp - kDown) * moveSpeed;
input_fire = kFire;


// original code from example project:
//
// var left = keyboard_check(vk_left);
// var right = keyboard_check(vk_right);
// var up = keyboard_check(vk_up);
// var down = keyboard_check(vk_down);

// input_hin = (right - left) * 100;
// input_buttons |= (up & 0x1) << 0;
// input_buttons |= (down & 0x1) << 1;