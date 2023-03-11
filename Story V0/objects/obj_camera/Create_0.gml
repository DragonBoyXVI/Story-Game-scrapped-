
if (instance_number(obj_camera) > 1) then {
	
	instance_destroy()
	exit
	
}

fun_init_rng() //test

state = STATES.FOLLOW_OBJ

trans_surf = -1

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

lens_current = 3
lens_tween = 3 //cur moves to tween

#endregion camera lens
#region layers

floor_layer = -1
floor_layer_asset = -1

#endregion layers
#region Shader

shader_uniform_color = shader_get_uniform(shd_replace_blackwhite, "new_color")
shader_uniform_percent = shader_get_uniform(shd_replace_blackwhite, "blend_per")

blend_amt = 0
blend_color = [0, 0, 0]
color_changed = false

#endregion Shader
#region pausing

can_pause = true
key_pause_press = ord("P")
has_menu = true
change_mods = true



#endregion pausing
#region music

loop_end = 0
loop_sub = 0

mus = -1
mus_prev = -1

mus_tex = -1
mus_tex_prev = -1

mus_tex_index = -1

mus_tex_ids = []

#endregion music