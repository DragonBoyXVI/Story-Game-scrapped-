
switch(sprite_index) {
	
	case spr_over_drac_needle_trans:
	
	face_right = not face_right
	face = face_right ? FACES.RIGHT : FACES.LEFT
	state = STATES.SP_DRAC_POISON
	sprite_index = face_right ? spr_over_drac_needle_hold_right : spr_over_drac_needle_hold_left
	
	break
	
	case spr_over_drac_needle_pull_right:
	case spr_over_drac_needle_pull_left:
	
	sprite_index = face_right ? spr_over_drac_needle_hold_right : spr_over_drac_needle_hold_left
	state = STATES.SP_DRAC_POISON
	
	break
	
}