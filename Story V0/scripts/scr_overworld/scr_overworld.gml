
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
		//show_debug_message("Index: {0} Snd: {1}", _index, _snd)
		if (_index and _snd != -1) then
			audio_play_sound_at(_snd, _x, _y, 0, 200, 400, 1, false, 1, _gain * SETTINGS_GAIN_SFX, 0, _pitch)
		
	}
	
}

#endregion sounds
#region shadows

function fun_draw_shadow(_x, _y, _sprite, _image, _xscale, _yscale, _yworld) {
	
	_yscale *= _yworld
	
	switch(_sprite) {
		
		default:
		draw_sprite_ext(spr_light, 0, _x, _y, 0.35*_xscale, 0.35*_yscale, 0, c_black, 0.5)
		break
		
		case spr_over_drac_walk_left:
		draw_sprite_ext(spr_light, 0, _x+16, _y, 0.65*_xscale, 0.35*_yscale, 0, c_black, 0.5)
		break
		
		case spr_over_drac_walk_right:
		draw_sprite_ext(spr_light, 0, _x-16, _y, 0.65*_xscale, 0.35*_yscale, 0, c_black, 0.5)
		break
		
	}
	
}

function fun_draw_self_water(_wtr_height = global.water_height) {
	
	var _xoff = sprite_get_xoffset(sprite_index), _yoff = sprite_get_yoffset(sprite_index)
	var _sprx = x - _xoff, _spry = y - _yoff
	var _sprite_xoff_w = sprite_width - _xoff, _sprite_yoff_h = sprite_height - _yoff
	
	draw_sprite_part_ext(sprite_index, image_index, 0, sprite_height-_wtr_height, sprite_width, _wtr_height, x-_xoff, y-_yoff+(sprite_height-_wtr_height), image_xscale, image_yscale, c_aqua, 0.75)
	draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width, sprite_height-_wtr_height, x-_xoff, y-_yoff, image_xscale, image_yscale, c_white, 1)
	
}
#endregion shadows
#region check for interacts

function fun_check_for_interact(_me, _touched) { //run inside me
	
	if not _touched or not _me then exit
	
	var _triggered = false
	
	switch(_me.object_index) {
		
		case obj_player:
		#region
		
		_triggered = _touched.is_player_trigger
		
		#endregion
		break
		
		case obj_player_bullet:
		case obj_dunder_overworld:
		#region
		
		_triggered = ( _touched.is_bullet_trigger and ( elem == _touched.bullet_elem or _touched.bullet_elem == ELEMENT.GARBO ) )
		
		#endregion
		break
		
		case obj_player_interact:
		#region
		
		_triggered = _touched.is_interact_trigger
		
		#endregion
		break
		
	}
	
	if (_triggered) then with _touched {
		
		if (is_method(on_trigger)) then {
			
			on_trigger()
			
		} else with instance_create_depth(0, 0, 0, obj_cutscene_manager) {
			
			scene_info = other.scene_info
			
		}
		
	}
	
	//show_debug_message(_triggered)
	
	return _triggered
	
}

#endregion check for interacts
#region level ups

function fun_get_exp(_lvl) {//max level 25
	
	return (power(2, _lvl/1.6) + (10 * _lvl))
	
}

function fun_give_exp_scaled(_exp, _level) {
	return _exp * (power(1.1, _level))
}

#endregion level ups
