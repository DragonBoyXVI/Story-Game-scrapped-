

if (paused) then { //draw the thing
	
	gpu_set_blendenable(false)
	
	surface_set_target(application_surface) //post draw targets the backbuffer, you should try to figure out what that is
	
	if (surface_exists(pause_surface)) then {
		
		draw_surface(pause_surface, 0, 0)
		
	} else {
		
		pause_surface = surface_create(stored_res_w, stored_res_h)
		buffer_set_surface(pause_buffer, pause_surface, 0)
		
	}
	
	gpu_set_blendenable(true)
	
	surface_reset_target()
	
}

//thanks shaun =3

if (key_pause or keyboard_check_pressed(key_unpause)) then {
	
	if (paused) then { //unpause the game
		
		instance_activate_all()
		paused = false
		
		if buffer_exists(pause_buffer) then buffer_delete(pause_buffer)
		if surface_exists(pause_surface) then surface_free(pause_surface)
		
		instance_deactivate_object(id)
		
	} else { //pause the game
		
		gui_w = display_get_gui_width()
		gui_h = display_get_gui_height()
		
		stored_res_w = surface_get_width(application_surface) //camera_get_view_width(VIEW) //SCREEN_WIDTH / obj_camera.lens_current
		stored_res_h = surface_get_height(application_surface) //camera_get_view_height(VIEW) //SCREEN_HEIGHT / obj_camera.lens_current
		
		cam_x = camera_get_view_x(VIEW)
		cam_y = camera_get_view_y(VIEW)
		
		//draw to the pause surf
		if (surface_exists(pause_surface)) then surface_free(pause_surface)
		pause_surface = surface_create(stored_res_w, stored_res_h)
		
		surface_set_target(pause_surface)
		draw_surface(application_surface, 0, 0)
		surface_reset_target()
		
		//save surface to buffer
		if (buffer_exists(pause_buffer)) then buffer_delete(pause_buffer)
		pause_buffer = buffer_create((stored_res_w * stored_res_h), buffer_fixed, 1)
		buffer_get_surface(pause_buffer, pause_surface, 0)
		
		paused = true
		instance_deactivate_all(true)
		
	}
	
}

key_pause = false
