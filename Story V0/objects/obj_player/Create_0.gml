
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

sprite_flips = false

spd = 4
swm_spd = 0.75

can_special = true

sprite_idle = array_create(2, -1) //all sprites should be drawn facing right if they flip
sprite_walk = array_create(2, -1)

function fun_set_player(_player) {
	
	switch(_player) {
		
		case PLAYERS.DRAC:
		#region set up drac
		
		sprite_flips = false
		
		sprite_walk[0] = spr_over_drac_idle_left //left
		sprite_walk[1] = spr_over_drac_idle_right //right
		
		sprite_walk[0] = spr_over_drac_walk_left //left
		sprite_walk[1] = spr_over_drac_walk_right //right
		
		#endregion set up drac
		break
		
	}
	
}

fun_set_player(PLAYERS.DRAC)