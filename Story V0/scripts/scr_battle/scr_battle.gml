
#region needs

function fun_battle_next(_wait = 0, _time_goes = GAMEMOD_ACTIVE_COMBAT) {
	
	cur_event = undefined
	
	actor = noone
	stored_id = noone
	stored_bool = false
	
	if (_time_goes and GAMEMOD_ACTIVE_COMBAT) then {
		timescale = 1/GAMEMOD_ACTIVE_DIV
		event_perform(ev_other, ev_user0)
		timescale = 1
	}
	
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

function fun_battle_randomize() {
	
	ds_list_shuffle(events)
	fun_battle_next(5)
	
}

#endregion random shit you wont ever fuckng need
#region make shit (not battle)

function fun_place_battle_unit(_x, _y, _beast_id, _teamlist, _player = undefined, _sumthin_special = undefined, _level_scaling = undefined) {
	
	var _me = instance_create_depth(_x, _y, -_y, obj_battle_unit)
	
	with _me {
		
		enemy_team = ( _teamlist == other.units[1] )
		ai_ctrl = _player == undefined ? enemy_team : _player
		
		beast_id = _beast_id
		
		sprite_index = spr_over_drac_needle_hold_right
		
		moveset_basic = [//[id, name]
			[MOVES.MELEE_ATK, "Melee Attack", "Strike a foe at close range, doing STR melee blunt damage. 20 time, 1 AP, 4 stamina."],
			[MOVES.DEFEND, "Defend", "Focus on defense for 5 seconds, halving all recived damage reguardless of source or type. 1 AP, 8 stamina."],
			[MOVES.REST, "Rest", "Spend 1 AP to recover 5 stamina and gain 1 regen."],
		]
		
		switch(beast_id) {
			
			case BEASTS.DRAC:
			#region
			
			moveset_basic[0] = [MOVES.RANGE_ATK, "Throw Pen", "Drac throws her pen, dealing STR ranged blunt damage."]
			
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

function fun_battleunit_speed(_id = id) {
	
	var _spd = -1
	
	with _id {
		
		_spd = stat_spd * ( mod_spd == 0 ? 1 : ( mod_spd > 0 ? STATUS_MOD_SPD_UP : STATUS_MOD_SPD_DOWN ) )
		_spd -= (poisoned > 0 ? STATUS_POISON_SPD : 0)
		_spd += (burning > 0 ? STATUS_BURN_SPD : 0)
		_spd *= ( in_water ? stat_swim_spd : 1 )
	
	}
	
	return _spd
	
}

function fun_battleunit_strength(_id = id) {
	
	var _str = -1
	
	with _id {
		
		_str = str + mod_str
		
	}
	
	return _str
	
}

function fun_battleunit_magic(_id = id) {
	
	var _mag = -1
	
	with _id {
		
		_mag = str + mod_str
		
	}
	
	return _mag
	
}

#endregion in battle functions
#region shit for the menu

function fun_move_to_menu_data(_move) {
	
	switch(_move) {
		
		case MOVES.MELEE_ATK:
		stored_data = [fun_battle_melee_attack, actor, NONE] //move function, data, data
		times_to_edit = 0 //what edit are we currently on?
		max_edits = 1 //how many times to edit
		what_menu = [5] //array of pages to look at
		edit_index = [2] //position in data to edit
		menu_message = ["Melee Attack Whom?"]
		break
		
	}
	
}

#endregion shit for the menu
#region move functions

function fun_aim(_actor, _target) {
	
	var _aim = _actor.aim
	
	if _actor.enemy_team == _target.enemy_team then {
		
		_aim = 100
		
	} else {
		
		_aim -= _target.defense
		
	}
	
	return _aim
	
}

function fun_hit(_actor, _target, _is_melee, _aim = fun_aim(_actor, _target)) {
	
	var _data = {hit: false, headshot: false}
	var _chance = fun_draw_rng()
	
	if (_actor.flying or (_actor.flying == _target.flying)) then {
		
		_data.hit = (_aim < _chance)
		_data.headshot = (_is_melee ? false : (_aim - 100) < _chance )
		
	}
	
	return _data
	
}

function fun_battle_melee_attack(_actor, _target) {
	
	if (!instance_exists(_actor) or _actor.ignore_me) then fun_battle_next()
	if (!instance_exists(_target) or _target.ignore_me) then fun_battle_next()
	
	var _data = fun_hit(_actor, _target, true)
	
	if (_data.hit) then {
		fun_battle_event([fun_battle_deal_damage, _actor, _target, fun_battleunit_strength(_actor), ELEMENT.BLUNT, 1])
		fun_battle_next(10)
		exit
	} else fun_battle_next()
	
}

function fun_battle_ranged_attack(_actor, _target) {
	
	if (!instance_exists(_actor) or _actor.ignore_me) then fun_battle_next()
	if (!instance_exists(_target) or _target.ignore_me) then fun_battle_next()
	
	var _data = fun_hit(_actor, _target, false)
	
	if (_data.hit) then {
		fun_battle_event([fun_battle_deal_damage, _actor, _target, fun_battleunit_strength(_actor), ELEMENT.BLUNT, 1])
		fun_battle_next(10)
		exit
	} else fun_battle_next()
	
}

#endregion move functions
#region damage

function fun_battle_deal_damage(_actor, _target, _dmg_amt, _element, _peirce) {
	
	
	
}

#endregion damage
#region status effects


#endregion status effects