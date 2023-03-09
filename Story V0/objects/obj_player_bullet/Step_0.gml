
x += lengthdir_x(spd ,direction)
y += lengthdir_y(spd ,direction)

depth = -bbox_bottom

image_angle = direction + sprite_rot_off

if fun_check_for_interact(id, collision_line(xprevious, yprevious, x, y, obj_cutscene_trigger, false, true)) then {
	
	instance_destroy()
	exit
	
}

if (collision_line(xprevious, yprevious, x, y, obj_wall_parent, false, true)) then {
	
	instance_destroy()
	
}