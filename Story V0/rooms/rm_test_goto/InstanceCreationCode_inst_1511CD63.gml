
is_player_trigger = true
is_bullet_trigger = true
is_interact_trigger = true

scene_info = [
	[fun_cut_over_mus, snd_over_test, 1],
	[fun_cut_change_room, rm_test, 500, 500, seq_battle_test_in, seq_black_diag_slideout],
]

/*
scene_info = [

	[fun_cut_object_move_tween, obj_player.id, -128, 0, 4, true],
	[fun_cut_wait, 0.1],
	[fun_cut_camera_point, 1000, 1000],
	[fun_cut_wait, 0.25],
	[fun_cut_camera_object, obj_player.id],
	[fun_cut_wait, 0.1],
]