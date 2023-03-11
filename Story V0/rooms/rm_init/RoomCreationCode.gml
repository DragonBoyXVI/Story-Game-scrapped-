
/*
with instance_create_depth(0, 0, 0, obj_game_pauser) {
	
	
	
}
*/

with instance_create_depth(300, 300, 0, obj_camera) {
	
	follow_obj = obj_player
	
}

with instance_create_depth(300, 300, 0, obj_player) {
	
	
	
}

room_goto(rm_test)