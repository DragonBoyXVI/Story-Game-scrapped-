
function fun_list_to_array(_list, _array = array_create(ds_list_size(_list))) {//convert a ds list to an array, keeps the list order
	
	var i = 0
	repeat(ds_list_size(_list)) {
		
		_array[i] = ds_list_find_value(_list, i)
		
		i++
		
	}
	
	return _array
	
}

function fun_battleunit_default_ai() {
	
	show_debug_message("\"ai\" is running?")
	
	///use attack on a random target
	//go to attack page and select it
	page = 1
	pos = 0
	key_enter = true
	event_perform(ev_step, ev_step_normal)
	key_enter = false
	
	//choose random target
	pos = round((array_length(book[page])-1)*(fun_draw_rng()/100))
	key_enter = true
	event_perform(ev_step, ev_step_normal)
	
}