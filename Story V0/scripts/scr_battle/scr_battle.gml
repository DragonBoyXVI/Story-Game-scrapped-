
#region needs

function fun_battle_next(_wait = 0, _time_goes = GAMEMOD_ACTIVE_COMBAT) {
	
	cur_event = undefined
	
	actor = noone
	stored_id = noone
	stored_bool = false
	
}

function fun_battle_event(_data, _end = false) {
	
	with obj_battle_manager {
			
		if (_end) then {
			
			ds_list_insert(events, ds_list_size(events), _data)
			
		} else {
			
			ds_list_insert(events, 0, _data)
			
		}
		
	}
	
}

#endregion needs
#region ap stuff

function fun_battle_give_ap_roundstart(_target, _amt) {
	
	if (not _target or !instance_exists(_target) or _target.ignore_me) then {
		
		fun_battle_next(0, false)
		exit
		
	}
	
	_target.ap += _amt
	fun_battle_next(0, false)
	
}

#endregion ap stuff
#region picking stuff

function fun_battle_pick_move(_target) {
	
	if (!instance_exists(_target) or _target.ignore_me) then {
		
		fun_battle_next(0, false)
		exit
		
	}
	
	if (!instance_exists(obj_battle_menu)) then {
		instance_create_depth(0, 0, 0, obj_battle_menu, {actor: _target, ai_ctrl: _target.ai_ctrl, state: 0})
	}
	
}

#endregion picking stuff
#region random shit you wont ever fuckng need



#endregion random shit you wont ever fuckng need
#region make shit (not battle)

function fun_place_battle_unit(_x, _y, _beast_id, _teamlist, _player = undefined, _sumthin_special = undefined, _level_scaling = undefined) {
	
	var _me = instance_create_depth(_x, _y, -_y, obj_battle_unit)
	
	with _me {
		
		enemy_team = ( _teamlist == other.units[1] )
		ai_ctrl = _player == undefined ? not enemy_team : _player
		
		beast_id = _beast_id
		
		sprite_index = spr_over_drac_needle_hold_right
		
		switch(beast_id) {
			
			case BEASTS.DRAC:
			#region
			name = "Drac"
			
			var _dat = global.game.data_drac
			
			rads = _dat.rads
			
			level = _dat.level
			
			stat_hp = _dat.hp
			stat_hp_max = _dat.hp_max
			stat_hp_max_real = _dat.hp_max
			
			stat_stam = _dat.stam
			stat_stam_max = _dat.stam
			stat_stam_regen = _dat.stam_regen
			
			stat_spd = _dat.spd
			
			stat_str = _dat.str
			stat_mag = _dat.mag
			
			stat_arm_base = 1
			
			stat_arm_elem = [1, 1.5, 0.75, 0.1, 1, 1, 1.05, 1.5]
			
			is_dragon = true
			is_naga = true
			
			race_organic = true
			
			immune_poisoned = true
			immune_acid = true
			immune_base = true
			
			uni_toxic_blood = true
			#endregion
			break
			
			case BEASTS.SHRUB:
			#region
			name = "Gettin ur ass kicked by a shrub lmao"
			
			level = irandom_range(global.enemy_level[0], global.enemy_level[1])
			
			stat_hp = 100
			stat_hp_max = 100
			stat_hp_max_real = 100
			
			stat_stam = 100
			stat_stam_max = 100
			stat_stam_regen = 100
			
			stat_spd = 1
			
			stat_str = 0
			stat_mag = 0
			
			stat_arm_base = 1
			
			race_organic = true
			
			if (_level_scaling == undefined) then {
				
				var _rand = 0
				repeat(level) {
					
					_rand = irandom(1)
					if (_rand) then {
						
						stat_hp += 5
						stat_hp_max += 5
						stat_hp_max_real += 5
						
					} else {
						
						stat_str += 1
						
					}
					
				}
				
			} else _level_scaling()
			
			#endregion
			break
			
		}
		
		if (is_method(_sumthin_special)) then _sumthin_special()
		
	}
	
	var i = 0
	var _placed = false
	var _cur_you = noone
	do {
		
		_cur_you = ds_list_find_value(_teamlist, i)
		
		if (_cur_you == undefined or _me.y > _cur_you.y) then {
			
			ds_list_insert(_teamlist, i, _me)
			_placed = true
			
		}
		
		i++
		
	} until (_placed)
	
}


#endregion make shit (not battle)
#region in battle functions

function fun_battleunit_speed() {
	
	var _spd = stat_spd * ( mod_spd == 0 ? 1 : ( mod_spd > 0 ? STATUS_MOD_SPD_UP : STATUS_MOD_SPD_DOWN ) )
	_spd -= (poisoned > 0 ? STATUS_POISON_SPD : 0)
	_spd += (burning > 0 ? STATUS_BURN_SPD : 0)
	_spd *= ( in_water ? stat_swim_spd : 1 )
	
	return _spd
	
}

#endregion in battle functions