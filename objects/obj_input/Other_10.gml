/// @description lockstep input latching

latch_hin = input_hin;
latch_vin = input_vin;
latch_fire = input_fire;

input_hin = 0;
input_vin = 0;
input_fire = 0;

debug_text = "Input: "
if (latch_hin == 0) {
	debug_text += "-";
} else {
	show_debug_message("hin=" + string(latch_hin));
	debug_text += latch_hin > 0 ? ">" : "<";
}

if (latch_vin == 0) {
	debug_text += "-";
} else {
	show_debug_message("vin=" + string(latch_vin));
	debug_text += latch_vin > 0 ? "^" : "v";
}

if (latch_fire) {
	debug_text += "X";
} else {
	debug_text += "-";
}

debug_text += " (";
debug_text += string(latch_hin);
debug_text += ", ";
debug_text += string(latch_vin);
debug_text += ", ";
debug_text += string(latch_fire);
debug_text += ")";