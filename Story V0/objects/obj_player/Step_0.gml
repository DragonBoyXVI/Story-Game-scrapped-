
var _yscale = YSCALE

#region state machine

switch(state) {
	
	case STATES.PLAY:
	#region standard play
	
	var _xspd = round( spd * (key_right - key_left) )
	var _yspd = round( spd * (key_down - key_up) * _yscale )
	
	x += _xspd
	y += _yspd
	
	#endregion standard play
	break
	
}

#endregion state machine