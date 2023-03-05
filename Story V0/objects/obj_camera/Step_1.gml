/// @description manage music

if (mus_cur != -1) then {
	
	var _pos = audio_sound_get_track_position(mus_cur)
	if (_pos >= loop_end) then audio_sound_set_track_position(mus_cur, _pos - loop_subtract)
	
}

if (mus_prev != -1 and audio_sound_get_gain(mus_prev) <= 0) then {
	audio_stop_sound(mus_prev)
	mus_prev = -1
}

#region

if keyboard_check_pressed(ord("0")) then {
	
	fun_camera_play_mus_overworld(snd_mus_test_overworld)
	
}

#endregion