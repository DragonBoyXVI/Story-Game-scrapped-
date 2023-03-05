
function fun_room_to_shader() {
	
	switch(room) {
		
		case rm_test:
		blend_color = array_create(3, 178/255)
		belnd_amt = 0.25
		break
		
		case rm_test_goto:
		blend_color = [107/255, 0, 0]
		belnd_amt = 0.25
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
		
	}
	
	lens_current = lens_tween
	
}