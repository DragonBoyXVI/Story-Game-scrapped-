
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
#region listener

audio_listener_position(x, y, 0)
audio_listener_velocity(x - xprevious, y - yprevious, 0)

#endregion listener