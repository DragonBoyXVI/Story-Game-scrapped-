
#region music to the camera

function fun_mus_to_params(_mus) {
	
	switch(_mus) {
		
		case snd_mus_test_overworld:
		loop_end = 46.8
		loop_subtract = 39
		break
		
	}
	
}

function fun_camera_play_mus_overworld(_mus = -1) {
	
	with obj_camera {
		
		if (mus_prev != -1) then {
			
			audio_stop_sound(mus_prev)
			
		}
		
		mus_prev = mus_cur
		if (mus_prev != -1) then {
			
			audio_sound_gain(mus_prev, 0, 1000)
			
		}
		
		if (_mus != -1) then {
			
			mus_cur = audio_play_sound(_mus, 2, false, 0)
			audio_sound_gain(mus_cur, SETTINGS_GAIN_MUS, 1000)
			
		} else {
			
			mus_cur = -1
			
		}
		
	}
	
}

#endregion music to the camera