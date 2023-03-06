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

if (mus != -1) then {
	
	var _pos = audio_sound_get_track_position(mus)
	if (_pos >= loop_end) then {
		
		audio_sound_set_track_position(mus, _pos - loop_sub)
		
		if (mus_tex != -1) then {
			
			audio_stop_sound(mus_tex)
			mus_tex = audio_play_sound(mus_tex_index, 2, false, 1)
			audio_sound_set_track_position(mus_tex, _pos - loop_sub)
			
		}
		
	}
	
	if keyboard_check(ord("I")) then {
		
		audio_sound_set_track_position(mus, loop_end - 2)
		audio_sound_set_track_position(mus_tex, loop_end - 2)
		
	}
	
}

if keyboard_check_pressed(ord("O")) then {
	fun_play_over_mus(snd_battle_test, 1)
	//show_debug_message("deedit")
}

if keyboard_check_pressed(ord("T")) then {
	fun_play_tex_music(snd_battle_test_drac, 1)
	//show_debug_message("deedit")
}


if keyboard_check_pressed(ord("U")) then {
	fun_play_over_mus(-1, 1)
	//show_debug_message("deedit")
}
if keyboard_check_pressed(ord("R")) then {
	fun_play_tex_music(-1, 1)
	//show_debug_message("deedit")
}