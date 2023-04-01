
var _cur_choice = book[page][pos]

switch(page) {
	
	case 0:
	#region go to other menus
		
		if key_enter then {
			
			switch(_cur_choice){
				case "Act": page = 1 break
				case "Skill": page = 2 break
				case "Item": page = 3 break
			}
			
		}
		
		#endregion go to other menus
	break
	
	case 1:
	#region the acts menu
	
	if key_backspace then {
		page = 0
		break
	}
	
	if key_enter then {
		
		if is_string(_cur_choice) then {
			page = 0
		} else {
			
			fun_move_to_menu_data(_cur_choice[0])
			page = what_menu[0]
			
		}
		
	}
	
	#endregion the acts menu
	break
	
	default:
	
	if key_backspace then {
		page = 0
		exit
	} else if key_enter then {
		
		if (is_string(_cur_choice)) then {
			page = 0
		} else {
			
			stored_data[edit_index[times_to_edit]] = _cur_choice
			if target_fucker_is_here_bool[times_to_edit] then actor.needed_target = _cur_choice //target_fucker_is_here_index = times_to_edit
			
			times_to_edit++
			
			if (times_to_edit == max_edits) then {
				
				actor.selected_move = [move_time_needed, stored_data]
				//actor.needed_target = target_fucker_is_here_index == -1 ? noone : stored_data[target_fucker_is_here_index]
				with obj_battle_manager fun_battle_next(0, false)
				instance_destroy(self)
				
			} else {
				
				page = what_menu[times_to_edit]
				
			}
			
		}
		
	}
	
	break
	
}