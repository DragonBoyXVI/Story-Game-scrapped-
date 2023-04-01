
#region move

switch(state) {
	
	case STATES.FOLLOW_OBJ:
	#region follow an object
	
	if (instance_exists(follow_obj)) then {
		
		x = lerp(x, follow_obj.x + follow_offx, spd_lerp)
		y = lerp(y, follow_obj.y + follow_offy, spd_lerp)
		
	}
	
	#endregion follow an object
	break
	
	case STATES.FOLLOW_POS:
	#region go to a point
	
	x = lerp(x, follow_x + follow_offx, spd_lerp)
	y = lerp(y, follow_y + follow_offy, spd_lerp)
	
	#endregion go to a point
	break
	
}

#endregion move
#region resize camera

if (lens_current != lens_tween) then {
	
	lens_current -= sign( lens_current - lens_tween )/10
	
	camera_set_view_size(VIEW, SCREEN_WIDTH/lens_current, SCREEN_HEIGHT/lens_current)
	
}

#endregion resize camera
#region listener

audio_listener_position(x, y, 0)
audio_listener_velocity(x - xprevious, y - yprevious, 0)

#endregion listener
#region pausing

if (!instance_exists(obj_cutscene_manager) and can_pause and keyboard_check_pressed(key_pause_press)) then {
	
	instance_activate_object(obj_game_pauser)
	
	if !instance_exists(obj_game_pauser) then instance_create_depth(x, y, depth, obj_game_pauser)
	
	obj_game_pauser.key_pause = true
	obj_game_pauser.key_unpause = key_pause_press
	obj_game_pauser.has_menu = has_menu
	obj_game_pauser.change_mods = change_mods
	
}

#endregion pausing
#region debug

//if (keyboard_check_pressed(ord("1"))) then lens_tween = 1
//if (keyboard_check_pressed(ord("2"))) then lens_tween = 2
//if (keyboard_check_pressed(ord("3"))) then lens_tween = 3

#endregion debug