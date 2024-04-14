/// @description manage music

if (mus_prev != -1) then {
	
	if (audio_sound_get_gain(mus_prev) <= 0) then {
		audio_stop_sound(mus_prev)
		mus_prev = -1
	}
	
}

if (mus_tex_prev != -1) then {
	
	if (audio_sound_get_gain(mus_tex_prev) <= 0) then {
		audio_stop_sound(mus_tex_prev)
		mus_tex_prev = -1
	}
	
}

if keyboard_check_pressed(ord("U")) then {
	fun_play_over_mus(-1, 1)
	//show_debug_message("deedit")
}