
if (instance_number(obj_camera) > 1) then {
	
	instance_destroy()
	exit
	
}

state = STATES.FOLLOW_OBJ

#region macky wackies

#macro SCREEN_WIDTH (1920)
#macro SCREEN_HEIGHT (1080)

#macro VIEW (view_camera[0])

display_set_gui_size(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

#endregion macky wackies
#region camera movement

spd_lerp = 0.25

follow_x = 0
follow_y = 0

follow_obj = noone

follow_offx = 0
follow_offy = -32

#endregion camera movement
#region camera lens

lens_current = 1
lens_tween = 1 //cur moves to tween

#endregion camera lens
#region pause stuff

pause_surf = -1
pause_buff = -1

#region pause stuff
