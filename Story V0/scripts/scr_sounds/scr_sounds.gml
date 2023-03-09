
#region music

function fun_mus_to_loops(_mus) {
	
	var _bias = -0.015
	
	switch(_mus) {
		
		case snd_over_test:
		loop_end = time_bpm_to_seconds(123) * 100 //46.8 + 1
		loop_sub = time_bpm_to_seconds(123) * 80 //31
		break
		
		case snd_battle_test:
		loop_end = time_bpm_to_seconds(155) * 345 //74.7
		loop_sub = time_bpm_to_seconds(155) * 324 //65.5
		break
		
	}
	
	loop_sub += _bias
	
}

function fun_play_over_mus(_mus = -1, _time_sec = 0.5, _pos = 0) {
	
	with obj_camera {
		
		if (mus_tex != -1) then audio_sound_gain(mus_tex, 0, _time_sec * 1000)
		
		if (mus_prev != -1) then {
		
		audio_stop_sound(mus_prev)
		mus_prev = -1
		
	}
		
		mus_prev = mus
		if (mus_prev != -1) then {
			audio_sound_gain(mus_prev, 0, _time_sec * 1000)
		}
		
		if (_mus != undefined and _mus != -1) then {
			
			mus = audio_play_sound(_mus, 2, true, 0, _pos)
			audio_sound_gain(mus, SETTINGS_GAIN_MUS, _time_sec * 1000)
			
		} else {
			mus = -1
			
			fun_play_tex_music(-1, _time_sec)
			
		}
		
		fun_mus_to_loops(_mus)
		
	}
	
}

function fun_play_tex_music(_mus = -1, _time_sec = 0.5) {
	
	with obj_camera {
		
		if (mus_tex_prev != -1) then {
			
			audio_stop_sound(mus_tex_prev)
			mus_tex_prev = -1
			
		}
		
		mus_tex_prev = mus_tex
		if (mus_tex_prev != -1) then {
			audio_sound_gain(mus_tex_prev, 0, _time_sec * 1000)
		}
		
		if (_mus != undefined and _mus != -1) then {
			
			mus_tex = audio_play_sound(_mus, 2, true, 0, audio_sound_get_track_position(mus))
			audio_sound_gain(mus_tex, SETTINGS_GAIN_MUS, _time_sec * 1000)
			
		}
		
		mus_tex_index = _mus
		
	}
	
}

#endregion music