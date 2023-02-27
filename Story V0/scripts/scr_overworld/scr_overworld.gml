
#region sounds

#macro SOUND_GRASS (choose(snd_grass_step_0, snd_grass_step_1, snd_grass_step_2))
#macro SOUND_CONC_CLAW (choose(snd_concrete_clawed_step_0, snd_concrete_clawed_step_1, snd_concrete_clawed_step_2))
#macro SOUND_METAL_HOLLOW_CLAW (choose(snd_metal_hollow_clawed_step_0, snd_metal_hollow_clawed_step_1, snd_metal_hollow_clawed_step_2))
#macro SOUND_METAL_CLAW (choose(snd_metal_step_clawed_0, snd_metal_step_clawed_1, snd_metal_step_clawed_2))
#macro SOUND_WOOD_CLAW (choose(snd_wood_step_clawed_0, snd_wood_step_clawed_1, snd_wood_step_clawed_2))

function fun_footstep_clawed(_x, _y, _floorasset) {
	
	if (_floorasset != -1) then {
		
		var _snd = -1, _pitch = random_range(0.9, 1.1), _gain = 0.75
		var _index = tilemap_get_at_pixel(_floorasset, _x, _y)
		
		var _set = tilemap_get_tileset(_floorasset)
		
		switch(_set) {//check what tile set you are using
			
			case ts_test_floors:
			#region test tiles
			
			if (_index == 1) then {_snd = SOUND_CONC_CLAW} else
			if (_index == 2) then {_snd = SOUND_GRASS} else
			if (_index == 3) then {_snd = SOUND_METAL_HOLLOW_CLAW; _pitch = random_range(0.8, 1.2); _gain = 1} else
			if (_index == 4) then {_snd = SOUND_METAL_CLAW} else
			if (_index == 5) then {_snd = SOUND_WOOD_CLAW; _pitch -= 0.1}
			
			#endregion test tiles
			break
			
		}
		
		if (_index and _snd) then
			audio_play_sound_at(_snd, _x, _y, 0, 200, 400, 1, false, 1, _gain, 0, _pitch)
		
	}
	
}

#endregion sounds