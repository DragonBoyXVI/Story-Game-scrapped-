
function fun_room_to_shader() {
	
	//show_debug_message("yes")
	
	switch(room) {
		
		case rm_test:
		blend_color = array_create(3, /*178*/255)
		blend_amt = 0.1
		break
		
		case rm_test_goto:
		blend_color = [107/255, 0, 0]
		blend_amt = 0.1
		break
		
		case rm_test_battle:
		blend_color = [25/255, 25/255, 173/255]
		blend_amt = 0.2
		break
		
	}
	
}
	
function fun_room_to_camsize() {
	
	switch(room) {
		
		case rm_test:
		lens_tween = 3
		break
		
		case rm_test_goto:
		lens_tween = 2
		break
		
		case rm_test_battle:
		lens_tween = 2
		break
		
	}
	
	lens_current = lens_tween
	
}