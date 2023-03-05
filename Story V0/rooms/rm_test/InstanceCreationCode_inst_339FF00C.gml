
is_player_trigger = true
is_bullet_trigger = true
is_interact_trigger = true

scene_info = [
	[fun_cut_change_room, rm_test_goto, 500, 500, seq_black_fadein, seq_black_fadeout],
]

/*
scene_info = [

	[fun_cut_object_move_tween, obj_player.id, -128, 0, 4, true],
	[fun_cut_set_instance_var_ext, [obj_player.id, "face_right", true], [obj_player.id, "face", FACES.RIGHT]],
	[fun_cut_wait, 0.5],
	[fun_cut_camera_point, 1000, 1000],
	[fun_cut_wait, 0.25],
	[fun_cut_camera_object, obj_player.id],
	[fun_cut_wait, 0.1],
]