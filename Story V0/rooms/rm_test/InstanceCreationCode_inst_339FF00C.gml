
is_player_trigger = true
is_bullet_trigger = true
is_interact_trigger = true
bullet_elem = ELEMENT.GARBO

scene_info = [
	[fun_cut_over_mus, snd_battle_test, 1],
	[fun_cut_change_room, rm_test_goto, 500, 500, seq_black_fast_fadein, seq_black_fast_fadeout],
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