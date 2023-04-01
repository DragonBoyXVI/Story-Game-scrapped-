/// @description battle unit charging

time_passed += timescale

#region check for a unit who needs to pick a move (test
/*
var i = 0
var _highest = noone, _highest_spd = -infinity, _cur_spd = 0
with obj_battle_unit {
	
	if (ap <= 0 or ignore_me) then {
		
		i++
		continue
		
	} else if (selected_move != undefined) then {
		
		continue
		
	}
	
	_cur_spd = fun_battleunit_speed()
	
	_highest = ( _cur_spd > _highest_spd ? id : _highest )
	_highest_spd = ( _cur_spd > _highest_spd ? _cur_spd : _highest_spd )
	
}

if (_highest == noone and i == instance_number(obj_battle_unit)) then {//no units can act, and no moves are charging
	
	round_count++
	
	with obj_battle_unit {
		
		var _ap = ap_speed + ap_instant
		ap_instant = 0
		_ap += ( mod_ap == 0 ? 0 : ( mod_ap > 0 ? 1 : -1 ) )
		
		fun_battle_event([fun_battle_give_ap_roundstart, id, _ap])
	
	}
	
}
*/
#endregion check for a unit who needs to pick a move eld

var i = 0

//check if a unit needs to pick a move
ds_priority_clear(queue)
with obj_battle_unit {
	
	age += other.timescale
	
	if (ap <= 0 or ignore_me) then {
		
		i++
		continue
		
	} else if (selected_move != undefined) then {
		
		continue
		
	}
	
	ds_priority_add(other.queue, id, fun_battleunit_speed())
	
}

//if any moves need to be selected, do that here
var _me = noone
repeat(ds_priority_size(queue)) {
	
	_me = ds_priority_find_min(queue)
	ds_priority_delete_min(queue)
	
	fun_battle_event([fun_battle_pick_move, _me])
	
}

//charge moves and tick stats
if (_me == noone) then {
	
	with obj_battle_unit {
		
		if ignore_me then continue
		
		if (selected_move == undefined) then continue
		
		if (needed_target != noone and !instance_exists(needed_target)) then {
			selected_move = undefined
			needed_target = noone
			show_message("oop")
			continue
		}
		
		spd_built += (fun_battleunit_speed() / game_get_speed(gamespeed_fps) * other.timescale)
		if (spd_built >= selected_move[0]) then {
			
			spd_built -= selected_move[0]
			fun_battle_event(selected_move[1])
			selected_move = undefined
			needed_target = noone
			
		}
		
	}
	
}

//give ap at the start of the round
if (_me == noone and i == instance_number(obj_battle_unit)) then {
	
	round_count++
	
	with obj_battle_unit {
		
		var _ap = ap_speed + ap_instant
		ap_instant = 0
		
		_ap += ( mod_ap == 0 ? 0 : ( mod_ap > 0 ? 1 : -1 ) )
		
		fun_battle_event([fun_battle_give_ap_roundstart, id, _ap])
		
	}
	
}