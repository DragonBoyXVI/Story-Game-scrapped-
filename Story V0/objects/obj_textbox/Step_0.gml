
if (typing) then {
	
	if (charwait > 0) then {
		
		charwait--
		
	} else {
		
		charpos += spd[page]
		charfloor = floor(charpos)
		
		var _curchar = string_char_at(text[page], charfloor)
		var _chartalk = true
		
		if (_curchar == "."
		or _curchar == ","
		or _curchar == "+"
		or _curchar == "-"
		or _curchar == "\""
		or _curchar == "?") then {
			charwait = spd[page]*5
			_chartalk = false
		}
		
		if (_curchar == " "
		or _curchar == "!"
		or _curchar == "#"
		or _curchar == "$"
		or _curchar == "%"
		or _curchar == "^"
		or _curchar == "("
		or _curchar == ")"
		or _curchar == "_"
		or _curchar == "{"
		or _curchar == "}"
		or _curchar == "["
		or _curchar == "]"
		or _curchar == "@") then {
			_chartalk = false
		}
		
		typing = (charfloor < charlength)
		
		if (sound[page] != -1) then {
			
			if (sound_once[page]) then {
				
				if (not sound_played) then {
					audio_play_sound(sound[page], 3, false, SETTINGS_GAIN_SFX)
					sound_played = true
				}
				
			} else {
				
				if (soundpos < charfloor and _chartalk) then {
					
					soundpos = charfloor
					audio_stop_sound(sound[page])
					audio_play_sound(sound[page], 3, false, SETTINGS_GAIN_SFX * random_range(0.9, 1.1), 0, random_range(0.9, 1.1))
					
				}
				
			}
			
		}
		
	}
	
	if (key_enter) then {
		
		charpos = charlength
		charfloor = charlength
		
		if (not sound_once[page]) then {
			
			audio_stop_sound(sound[page])
			audio_play_sound(sound[page], 3, false, SETTINGS_GAIN_SFX, 0, 1.5)
			
		}
		
	}
	
} else {
	
	pos = options[page] == -1 ? 0 : clamp(pos + (key_down - key_up), 0, opts_length - 1)
	
	if (key_enter) then {
		
		if (options[page] == -1) then {
			
			page++
			
			if (page >= page_number) then {
				
				with obj_cutscene_manager fun_cut_end()
				instance_destroy()
				
			}
			
		} else {
			
			fun_option_results(options[page][pos][1])
			instance_destroy()
			
		}
		
	}
	
}