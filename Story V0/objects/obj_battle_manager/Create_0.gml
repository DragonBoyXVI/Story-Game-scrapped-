events = ds_list_create()
cur_event = undefined

framewait = 0

units[0] = ds_list_create() //player side
units[1] = ds_list_create() //enemy 

scripted_rounds = array_create(1000, -1)
//scripted_rounds[0] = {scene_info: [[fun_cut_textbox, "test"]]}

round_count = 0
timescale = 1

state = 0
queue = ds_priority_create()

switch(global.battle_id) { //create da battle
	
	case "test":
	fun_place_battle_unit(300, 300, BEASTS.DRAC, units[0])
	fun_place_battle_unit(600, 350, BEASTS.SHRUB, units[1])
	
	//global.tex_music = [snd_battle_test_drac, -1, -1, -1, -1]
	break
	
}

battle_id = global.battle_id

exp_collected = 0
items_collected = []

#region cutscene related

time_passed = 0

actor = noone

stored_id = noone
stored_bool = false

#endregion cutscene related