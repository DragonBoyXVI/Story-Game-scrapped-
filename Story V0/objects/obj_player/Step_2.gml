
switch(state) {
	
	default:
	fun_change_sprite()
	break
	
	case STATES.SPEC: break
	case STATES.SP_DRAC_BULLET: break
	case STATES.SP_DRAC_DUNDER: if !instance_exists(obj_dunder_overworld) then state = STATES.PLAY break
	
}