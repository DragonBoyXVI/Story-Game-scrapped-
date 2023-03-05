
var _yscale = YSCALE

#region state machine

switch(state) {
	
	case STATES.PLAY:
	#region standard play
	
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
	
	#region enter key
	
	if (key_enter) then {
		
		with obj_player_interact instance_destroy()
		
		switch(face) {
			
			case FACES.LEFT:
			instance_create_depth(x-64, y, depth, obj_player_interact)
			break
			
			case FACES.RIGHT:
			instance_create_depth(x+64, y, depth, obj_player_interact)
			break
			
			case FACES.UP:
			instance_create_depth(x, y-64, depth, obj_player_interact)
			break
			
			case FACES.DOWN:
			instance_create_depth(x, y+64, depth, obj_player_interact)
			break
			
		}
		
	}
	
	#endregion enter key
	
	#region special
	
	if (can_special) then {
		
		switch(GAME_CURPLAYER) {
			
			case PLAYERS.DRAC:
			#region drac specials
			
			if (mouse_right_clicked) then { //posion
				
				state = STATES.TRANS //SP_DRAC_POISON
				image_index = 0
				sprite_index = face_right ? spr_over_drac_needle_pull_right : spr_over_drac_needle_pull_left
				
			} else if (mouse_left_clicked) { //jump
				
				
				
			}
			
			#endregion drac specials
			break
			
		}
		
	}
	
	#endregion special
	
	#endregion standard play
	break
	
	case STATES.SP_DRAC_POISON:
	#region drac needle
	
	var _mouse_right = (mouse_x > x)
	
	if (_mouse_right != face_right) then {
		
		image_index = 0
		sprite_index = spr_over_drac_needle_trans
		state = STATES.TRANS
		
	}
	
	if (mouse_right_released) then state = STATES.PLAY
	
	#endregion drac needle
	break
	
}

#endregion state machine
#region check for water

if (water_layer_elem != -1) then {
	
	var _now = in_water
	in_water = tilemap_get_at_pixel(water_layer_elem, x, y-global.water_height) == 1
	
	//audio_bus_main.effects[4].bypass = not in_water
	
}

#endregion check for water