
if instance_exists(obj_cutscene_manager) or layer_exists(ANIM_LAYER_NAME) then exit

if (framewait > 0) then {
	
	framewait--
	exit
	
}

//check if an event is pending
if (cur_event == undefined) then {
	
	cur_event = ds_list_find_value(events, 0)
	ds_list_delete(events, 0)
	
	//if there is no event, loop thru the units
	if (cur_event == undefined) then {
		
		event_perform(ev_other, ev_user0)
		
	}
	
} else { //do event if one exists, event end will clear cur_evet
	
	script_execute_ext(cur_event[0], cur_event, 1)
	
}