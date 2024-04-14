
switch(sprite_index) {
	
	default: break
	
	case spr_over_drac_needle_pullup_left:
	case spr_over_drac_needle_pullup_right:
	#region
	
	state = STATES.SP_DRAC_BULLET
	sprite_index = face_right ? spr_over_drac_needle_hold_right : spr_over_drac_needle_hold_left
	
	#endregion
	break
	
	case spr_over_drac_needle_fire_left:
	case spr_over_drac_needle_fire_right:
	case spr_over_drac_dunder_spike_right:
	case spr_over_drac_dunder_spike_left:
	fun_change_sprite()
	state = STATES.PLAY
	break
	
	case spr_over_drac_needle_trans:
	#region 
	
	state = STATES.SP_DRAC_BULLET
	face_right = not face_right
	sprite_index = face_right ? spr_over_drac_needle_hold_right : spr_over_drac_needle_hold_left
	face = face_right ? FACES.RIGHT : FACES.LEFT
	
	#endregion 
	break
	
	case spr_over_drac_dunder_begin_left:
	case spr_over_drac_dunder_begin_right:
	state = STATES.SP_DRAC_DUNDER
	sprite_index = face_right ? spr_over_drac_dunder_idle_right : spr_over_drac_dunder_idle_left
	break
	
}