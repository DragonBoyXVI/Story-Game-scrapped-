
depth = -bbox_bottom

switch(state) {
	
	case 0:
	#region movin around
	
	var _up, _down, _left, _right, _click_left
	_left = my_owner.key_left
	_down = my_owner.key_down
	_up = my_owner.key_up
	_right = my_owner.key_right
	_click_left = my_owner.mouse_left_released
	
	var _xspd = round(spd * (_right - _left))
	var _yspd = round(spd * (_down - _up) * image_yscale)
	
	//x += _xspd
	//y += _yspd
	
	x = clamp(x + _xspd, 0, room_width)
	y = clamp(y + _yspd, 0, room_height)
	
	var _dist = point_distance(x, y, xstart, ystart)
	
	while(_dist > teather_length) {
		
		x -= (sign(x - xstart))
		y -= (sign(y - ystart))
		
		_dist = point_distance(x, y, xstart, ystart)
		
	}
	
	if (_click_left) then {
		
		state = 1
		
		with my_owner {
			state = STATES.SPEC
			image_index = 0
			sprite_index = face_right ? spr_over_drac_dunder_spike_right : spr_over_drac_dunder_spike_left
		}
		
	}
	
	#endregion movin around
	break
	
	case 2:
	
	state = 3
	
	image_index = 0
	sprite_index = spr_dunder_strike
	
	break
	
	case 4:
	
	if (image_alpha <= 0) then instance_destroy()
	else image_alpha -= 0.02
	
	break
	
}