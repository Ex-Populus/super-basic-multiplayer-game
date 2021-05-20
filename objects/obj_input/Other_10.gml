/// @description lockstep input latching

latch_hin = input_hin;
latch_vin = input_vin;
latch_fire = input_fire;

debug_text = "Input: "
if (latch_hin == 0) {
	debug_text += "0";
} else {
	debug_text += latch_hin > 0 ? ">" : "<";
}

if (latch_vin == 0) {
	debug_text += "0";
} else {
	debug_text += latch_vin > 0 ? "^" : "v";
}

if (latch_fire) {
	debug_text += "X";
}

input_hin = 0;
input_vin = 0;
input_fire = 0;