
#region inputs

mouse_left = false
mouse_left_clicked = false
mouse_left_released = false

mouse_right = false
mouse_right_clicked = false
mouse_right_released = false

key_up = false
key_down = false
key_left = false
key_right = false

key_enter = false

#endregion inputs

state = STATES.PLAY

sprite_flips = false
face_right = true
face = 0

spd = 4
swm_spd = 0.75

in_water = false

can_special = true

sprite_idle = array_create(2, -1) //all sprites should be drawn facing right if they flip
sprite_walk = array_create(2, -1)

wall_layer_elem = -1
water_layer_elem = -1
dark_spot_elem = -1

bbox_width = -1
bbox_height = -1

function fun_set_player(_player) {
	
	GAME_CURPLAYER = _player
	
	switch(_player) {
		
		case PLAYERS.DRAC:
		#region set up drac
		
		spd = 5
		swm_spd = 0.75
		
		sprite_flips = false
		
		sprite_idle[0] = spr_over_drac_idle_left //left
		sprite_idle[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up drac
		break
		
		case PLAYERS.KATE:
		#region set up kate
		
		spd = 3
		swm_spd = 0.45
		
		sprite_flips = true
		
		sprite_idle[0] = spr_over_drac_idle_left //left
		sprite_idle[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up kate
		break
		
		case PLAYERS.MUD:
		#region set up mud
		
		spd = 4
		swm_spd = 0.8
		
		sprite_flips = false
		
		sprite_idle[0] = spr_over_drac_idle_left //left
		sprite_idle[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up mud
		break
		
		case PLAYERS.FEVIR:
		#region set up fev
		
		spd = 3
		swm_spd = 0.45
		
		sprite_flips = true
		
		sprite_idle[0] = spr_over_drac_idle_left //left
		sprite_idle[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up fev
		break
		
		case PLAYERS.JAB:
		#region set up jab
		
		spd = 4
		swm_spd = 1.25
		
		sprite_flips = false
		
		sprite_idle[0] = spr_over_drac_idle_left //left
		sprite_idle[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up jab
		break
		
	}
	
	mask_index = sprite_walk[1]
	
	bbox_width = bbox_right - bbox_left
	bbox_height = bbox_bottom - bbox_top
	
	bbox_left_to_center = bbox_left - x
	bbox_right_to_center = bbox_right - x
	
	bbox_top_to_center = bbox_top - y
	bbox_bottom_to_center = bbox_bottom - y
	
}

function fun_change_sprite() {
	
	var _xmoved = ( x != xprevious)
	var _ymoved = ( y != yprevious)
	
	if (_xmoved) then {
		
		var _xdir = sign(x - xprevious)
		face_right = (x > xprevious)
		
		sprite_index = sprite_walk[ sprite_flips ? 1 : face_right ]
		image_xscale = sprite_flips ? _xdir : 1
		face = _xdir == 1 ? FACES.RIGHT : FACES.LEFT
		
	} else if (_ymoved) then {
		
		var _ydir = sign(y - yprevious)
		
		sprite_index = sprite_walk[ sprite_flips ? 1 : face_right ]
		face = _ydir == 1 ? FACES.DOWN : FACES.UP
		
	} else { //no x or y movement
		
		sprite_index = sprite_idle[ sprite_flips ? 1 : face_right ]
		
	}
	
}

fun_set_player(PLAYERS.DRAC)