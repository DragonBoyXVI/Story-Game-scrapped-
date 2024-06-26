
//part_particles_create(global.part_sys, x+random_range(-sprite_width/2, sprite_width/2), y-random(sprite_height), global.poison_type, choose(0, 0, 1))
//effect_create_above(ef_rain, 0, 0, 1, c_blue)

var _yscale = YSCALE

#region state machine

switch(state) {
	
	case STATES.PLAY:
	#region standard play
	
	#region testing
	
	if (keyboard_check(vk_shift)) then {
		if keyboard_check_pressed(ord("1")) then fun_set_player(PLAYERS.DRAC)
		if keyboard_check_pressed(ord("2")) then fun_set_player(PLAYERS.KATE)
		if keyboard_check_pressed(ord("3")) then fun_set_player(PLAYERS.MUD)
		if keyboard_check_pressed(ord("4")) then fun_set_player(PLAYERS.FEVIR)
		if keyboard_check_pressed(ord("5")) then fun_set_player(PLAYERS.JAB)
	}
	
	YSCALE += (keyboard_check(ord("L")) - keyboard_check(ord("K")))/100
	
	#endregion testing
	
	var _wtr = in_water ? swm_spd : 1
	
	var _xspd = round( spd * (key_right - key_left) * _wtr )
	var _yspd = round( spd * (key_down - key_up) * _wtr * _yscale )
	
	#region tile walls
	
	if (wall_layer_elem != -1) then {
		
		if (_xspd != 0) then {
			
			var _bbox_dir = sign(_xspd) ? bbox_right : bbox_left
			
			while (tilemap_get_at_pixel(wall_layer_elem, _bbox_dir + _xspd, y) != 0
			or tilemap_get_at_pixel(wall_layer_elem, _bbox_dir + _xspd, y - bbox_height/2) != 0
			or tilemap_get_at_pixel(wall_layer_elem, _bbox_dir + _xspd, y - bbox_height) != 0) {
				
				_xspd -= sign(_xspd)
				if _xspd == 0 then break
				
			}
			
		}
		
		if (_yspd != 0) then {
			
			var _bbox_dir = sign(_yspd) ? bbox_bottom : bbox_top
			
			while (tilemap_get_at_pixel(wall_layer_elem, x, _bbox_dir + _yspd) != 0
			or tilemap_get_at_pixel(wall_layer_elem, x - bbox_width/2, _bbox_dir + _yspd) != 0
			or tilemap_get_at_pixel(wall_layer_elem, x + bbox_width/2, _bbox_dir + _yspd) != 0) {
				
				_yspd -= sign(_yspd)
				if _yspd == 0 then break
				
			}
			
		}
		
	}
	
	#endregion tile walls
	
	#region object walls
	
	if (_xspd != 0) then {
		
		while (place_meeting(x + _xspd, y, obj_wall_parent)) {
			
			_xspd -= sign(_xspd)
			if _xspd == 0 then break
			
		}
		
	}
	
	if (_yspd != 0) then {
		
		while (place_meeting(x, y + _yspd, obj_wall_parent)) {
			
			_yspd -= sign(_yspd)
			if _yspd == 0 then break
			
		}
		
	}
	
	#endregion object walls
	
	x += _xspd
	y += _yspd
	
	#region check for interacts
	
	if fun_check_for_interact(id, instance_place(x, y, obj_cutscene_trigger)) then exit
	
	#endregion check for interacts
	
	#region check interact
	
	if (key_enter) then {
		
		instance_destroy(obj_player_interact)
		
		switch(face) {
			
			case FACES.RIGHT:
			instance_create_depth(x+32, y, depth, obj_player_interact)
			break
			
			case FACES.LEFT:
			instance_create_depth(x-32, y, depth, obj_player_interact)
			break
			
			case FACES.UP:
			instance_create_depth(x, y-48, depth, obj_player_interact)
			break
			
			case FACES.DOWN:
			instance_create_depth(x, y+32, depth, obj_player_interact)
			break
			
		}
		
	}
	
	#endregion check interact
	
	#region check specials
	
	if (can_special) then {
		
		if (mouse_right_clicked) then {
			
			switch(GAME_CURPLAYER) {
				
				case PLAYERS.DRAC:
				#region needle
				
				state = STATES.SPEC
				image_index = 0
				sprite_index = face_right ? spr_over_drac_needle_pullup_right : spr_over_drac_needle_pullup_left
				
				#endregion nelde
				break
				
			}
			
		} else if (mouse_left_clicked) then {
			
			switch(GAME_CURPLAYER) {
				
				case PLAYERS.DRAC:
				#region dunder
				
				state = STATES.SPEC
				image_index = 0
				sprite_index = face_right ? spr_over_drac_dunder_begin_right : spr_over_drac_dunder_begin_left
				//obj_camera.follow_obj = obj_dunder_overworld
				
				#endregion dunder
				break
				
			}
			
		}
		
	}
	
	#endregion check specials
	
	#endregion standard play
	break
	
	case STATES.SP_DRAC_BULLET:
	#region drac throwing her poison
	
	var _mouse_face = (mouse_x > x)
	
	if (face_right != _mouse_face) then {
		
		state = STATES.SPEC
		image_index = 0
		sprite_index = spr_over_drac_needle_trans
		exit
		
	}
	
	if (mouse_right_released) then {
		
		sprite_index = face_right ? spr_over_drac_needle_fire_right : spr_over_drac_needle_fire_left
		image_index = 0
		state = STATES.SPEC
		
	}
	
	#endregion drac throwing his poison
	break
	
}

#endregion state machine
#region check for water

if (water_layer_elem != -1) then {
	
	var _now = in_water
	in_water = (tilemap_get_at_pixel(water_layer_elem, x, y) == 1 or tilemap_get_at_pixel(water_layer_elem, x, y-global.water_height) == 1)
	
	//audio_bus_main.effects[4].bypass = not in_water
	
}

#endregion check for water