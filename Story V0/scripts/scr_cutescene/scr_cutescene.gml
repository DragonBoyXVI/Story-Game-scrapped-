#region setup
 
 function fun_cut_end() {
	
	stored_id = noone
	stored_x = undefined
	stored_y = undefined
	
	timer = undefined
	
	run_once = true
	
	scene++
	if (scene >= array_length(scene_info)) then {
		
		instance_destroy()
		
	}
	
 }
 
 #endregion setup
#region move an object
 
 function fun_cut_object_move_tween(_id, _x, _y, _spd, _relative) {
	
	if (stored_x == undefined or stored_y == undefined) then {
		
		stored_x = ( _relative ? _id.x + _x : _x )
		stored_y = ( _relative ? _id.y + _y : _y )
		
	}
	
	var _xx = stored_x, _yy = stored_y
	
	with _id {
		
		if (point_distance(x, y, _xx, _yy) <= _spd) then {
			
			x = _xx
			y = _yy
			
			with other fun_cut_end()
			
		} else {
			
			var _dir = point_direction(x, y, _xx, _yy)
			
			x += lengthdir_x(_spd, _dir)
			y += lengthdir_y(_spd, _dir) * global.yscale
			
		}
		
	}
	
 }
 
 function fun_cut_camera_point(_x, _y) {
	
	if (stored_id == noone) then {
		
		stored_id = -1
		
		with obj_camera {
			
			state = STATES.FOLLOW_POS
			follow_x = _x
			follow_y = _y
			
		}
		
	}
	
	with obj_camera {
		
		if (point_distance(x, y, follow_x + follow_offx, follow_y + follow_offy) <= 32) then
		 with other fun_cut_end()
		
	}
	
 }
 
 function fun_cut_camera_object(_id) {
	
	if (stored_id == noone) then {
		
		stored_id = -1
		
		with obj_camera {
			
			state = STATES.FOLLOW_OBJ
			follow_obj = _id
			
		}
		
	}
	
	with obj_camera {
		
		if (point_distance(x, y, _id.x + follow_offx, _id.y + follow_offy) <= 32) then
			with other fun_cut_end()
		
	}
	
 }
 
 #endregion move an object
#region time
 
 function fun_cut_wait(_sec) {
	
	timer = timer ?? round(_sec * game_get_speed(gamespeed_fps))
	
	timer--
	
	if (timer <= 0) then {
		
		fun_cut_end()
		
	}
	
 }
 
 #endregion time
#region change rooms
//thank you random citizen
function fun_layer_surface_set() {
	
	if (event_type == ev_draw) then {
		
		if (event_number == ev_draw_normal) then {
			
			with obj_camera { if !surface_exists(trans_surf) then trans_surf = surface_create(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) }
			shader_reset()
			surface_set_target(obj_camera.trans_surf)
			draw_clear_alpha(c_white, 0)
			
		}
		
	}
	
}

function fun_layer_surface_unset() {
	
	if (event_type == ev_draw) then {
		
		if (event_number == 0) then {
			
			surface_reset_target()
			with obj_camera event_perform(ev_draw, ev_draw_pre)
			
		}
		
	}
	
}

//SHAUN!!! SHAUN!!!
function fun_trans_place_seq(_type, _x = camera_get_view_x(VIEW), _y = camera_get_view_y(VIEW), _scale = 2/obj_camera.lens_current) {
	
	if layer_exists("trans") then layer_destroy("trans")
	var _layer = layer_create(-9999, "trans")
	var _seq = layer_sequence_create(_layer, _x, _y, _type)
	layer_sequence_xscale(_seq, _scale)
	layer_sequence_yscale(_seq, _scale)
	
	layer_script_begin(_layer, fun_layer_surface_set)
	layer_script_end(_layer, fun_layer_surface_unset)
	
	//show_debug_message("{0} {1}", seq_black_fadein, _type)
	
	return _seq
	
}
 
function fun_trans_start(_target, _innie, _outie) {
	
	if (!global.in_trans) then {
		
		global.in_trans = true
		global.stored_room = _target
		fun_trans_place_seq(_innie, 0, 0, 1)
		
		layer_set_target_room(_target)
		fun_trans_place_seq(_outie, 0, 0, 1)
		layer_reset_target_room()
		
		return true
		
	} else return false
	
 }

function fun_trans_goto() {
	
	//if not global.in_trans then exit
	
	layer_sequence_destroy(self.elementID)
	layer_destroy("trans")
	room_goto(global.stored_room)
 }

function fun_trans_done() {
	
	layer_sequence_destroy(self.elementID)
	global.in_trans = false
	
	layer_destroy("trans")
	
	with obj_cutscene_manager fun_cut_end()
	
 }

function fun_create_anim(_aim) {
	
	if layer_exists(ANIM_LAYER_NAME) then layer_destroy(ANIM_LAYER_NAME)
	var _layer = layer_create(-9998, ANIM_LAYER_NAME)
	var _seq = layer_sequence_create(_layer, 0, 0, _aim)
	
	layer_script_begin(_layer, fun_layer_surface_set)
	layer_script_end(_layer, fun_layer_surface_unset)
	
	return _seq
	
}

function fun_create_move_anim(_anim, _x = 0, _y = 0, _depth = -999) {
	
	if layer_exists(ANIM_LAYER_NAME) then layer_destroy(ANIM_LAYER_NAME)
	var _layer = layer_create(_depth, ANIM_LAYER_NAME)
	var _seq = -layer_sequence_create(_layer, _x, _y, _anim)
	
	return _seq
	
}

function fun_kill_anim() {
	
	layer_sequence_destroy(self.elementID)
	layer_destroy(ANIM_LAYER_NAME)
	
}

function fun_cut_change_room(_room, _playerx, _playery, _in, _out) {
	
	if not global.in_trans then {
		
		fun_trans_start(_room, _in, _out)
		
		stored_id = room
		
	}
	
	if (stored_id != room) then {
		
		obj_player.x = _playerx
		obj_player.y = _playery
		
		obj_camera.x = _playerx
		obj_camera.y = _playery
		
	}
	
 }

/// BATTLE STARTING SHIT HERRE

function fun_cut_make_battle(_battle_id, _battle_room, _in, _out) {
	
	if not global.in_trans then {
		
		fun_trans_start(_battle_room, _in, _out)
		stored_id = room
		room_persistent = true
		
		global.battle_before_room = room
		global.battle_id = _battle_id
		
		switch(_battle_id) {//battle music
			
			default:
			//fun_play_over_mus(snd_battle_test, 0.1)
			fun_play_over_mus(snd_mus_battle_fevir_test, 0)
			//global.tex_music = [snd_battle_test_drac, -1, -1, -1, -1]
			global.tex_music = [-1, -1, -1, -1, -1]
			break
			
		}
		
	}
	
	if (stored_id != room) then {
		
		obj_player.x = -1000
		obj_player.y = -1000
		obj_player.state = -1
		
		obj_camera.x = room_width/2
		obj_camera.y = room_height/2
		
		obj_camera.state = STATES.FOLLOW_POS
		obj_camera.follow_offy = 0
		obj_camera.follow_offx = 0
		
		obj_camera.follow_x = room_width/2
		obj_camera.follow_y = room_height/2
		
		obj_camera.lens_tween = 2
		
		if !instance_exists(obj_battle_manager) then instance_create_depth(0, 0, 0, obj_battle_manager)
		
	}
	
}

function fun_cut_end_battle(_innie, _outie) {
	
	if not global.in_trans then {
		
		fun_trans_start(global.battle_before_room, _innie, _outie)
		stored_id = room
		instance_destroy(obj_battle_manager)
		
	}
	
	if (stored_id != room) then {
		
		obj_player.x = global.stored_coords[0]
		obj_player.y = global.stored_coords[1]
		
		obj_camera.x = obj_player.x
		obj_camera.y = obj_player.y
		obj_camera.state = STATES.FOLLOW_OBJ
		obj_camera.follow_obj = obj_player
		obj_camera.follow_offy = -32
		
		room_persistent = false
		
	}
	
}

#endregion change rooms
#region this is where all the textbox stuff is

function fun_cut_textbox(_textid) {//make cutscene textbox
	
	if (stored_id == noone) then {
		
		stored_id =instance_create_depth(0, 0, 0, obj_textbox)
		
		with stored_id {
			
			fun_gametext(_textid)
			
		}
		
	}
	
}

function fun_text(_text, _color = c_black, _char = -1) {
		
	text[page_number] = _text
	text_color[page_number] = _color
	
	font[page_number] = fun_player_font()
	
	header[page_number] = -1
	header_color[page_number] = _color
	
	options[page_number] = -1 //will be an array if this has ops, [text, new scene id, otherwise -1]
	option_color_sele[page_number] = fun_player_colour()
	
	bust_talk[page_number] = -1
	bust_idle[page_number] = -1 //checked for when using busts
	
	bust_side_right[page_number] = false
	bust_face_right[page_number] = false
	
	sound[page_number] = -1 //snd_metal_hollow_clawed_step_0
	sound_once[page_number] = false
	
	box_sprite[page_number] = fun_player_textbox()
	
	spd[page_number] = 1
	
	switch(_char) {
		
		default: break
		
	}
	
	page_number++
	
}

function fun_text_data_deets(_spd, _box_sprite, _font, _farback = -1) {
	
	var i = 0
	repeat(_farback) {
		
		spd[page_number - i] = _spd
		box_sprite[page_number - i] = _box_sprite
		font[page_number - i] = _font
		
		i++
		
	}
	
}

function fun_text_data_header(_text, _color, _farback = 1) {
	
	var i = 1
	repeat(_farback) {
		
		header[page_number - i] = _text
		header_color[page_number - i] = _color
		
		i++
		
	}
	
}

function fun_text_data_bust(_talk, _idle, _faces_right, _on_side_right, _farback = 1) {
	
	var i = 1
	repeat(_farback) {
		
		bust_talk[page_number - i] = _talk
		bust_idle[page_number - i] = _idle
		bust_face_right[page_number - i] = _faces_right
		bust_side_right[page_number - i] = _on_side_right
		
		i++
		
	}
	
}

function fun_text_data_sound(_sound, _once = false, _farback = 1) {
	
	var i = 1
	repeat(_farback) {
		
		sound[page_number - i] = _sound
		sound_once[page_number - i] = _once
		
		i++
		
	}
	
}

function fun_text_option(_text, _textid, _sele_color = fun_player_colour()) {
	
	var _page = page_number - 1
	
	if (options[_page] == -1) then {
		
		options[_page] = [[_text, _textid]]
		
	} else {
		
		array_push(options[_page], [_text, _textid])
		
	}
	
	option_color_sele[_page] = _sele_color
	
}

function fun_gametext(_textid) {
	
	switch(_textid) {
		
		default:
		fun_text(string("Unknown id: {0}", _textid))
		break
		
		case "test": 
		fun_text("Heyeye")
		fun_text("YEEEEEEEEEEEEEEEEEEE HEHHEHEHEHEHE. EHEHHEHEHE EHHEHEHEHEHE KKZKKZKZKZKZKKZKZ")
		fun_text("Okie thank you naow answer this")
		fun_text("do you liek gaming?")
			fun_text_data_sound(snd_wood_step_clawed_0, false, 4)
			fun_text_data_deets(0.1, spr_pix_hollow, -1, 2)
			
			fun_text_option("Yes i love gayms", "test true")
			fun_text_option("No i'm homophonic", "test false")
			fun_text_option("take me to the other room", "test trans")
		break
		
		case "test true":
		fun_text("Yay gaming")
		break
		
		case "test false":
		fun_text("*shits pants cutely*")
		break
		
		case "test trans 0":
		fun_text("Yessir")
		break
		
		case "test trans 1":
		fun_text("Done =3")
		break
		
	}
	
}

function fun_option_results(_textid) {
	
	instance_destroy(obj_cutscene_manager)
	
	with instance_create_depth(0, 0, 0, obj_cutscene_manager) {
		
		switch(_textid) {
			
			default:
			scene_info = [
				[fun_cut_textbox, -1],
			]
			break
			
			case "test true":
			scene_info = [
				[fun_cut_textbox, "test true"],
				[fun_cut_object_move_tween, obj_player.id, 0, -64, obj_player.spd, true],
			]
			break
			
			
			case "test false":
			scene_info = [
				[fun_cut_textbox, "test false"],
				[fun_cut_object_move_tween, obj_player.id, 0, -64, obj_player.spd, true],
			]
			break
			
			case "test trans":
			scene_info = [
				[fun_cut_textbox, "test trans 0"],
				[fun_cut_change_room, rm_test_goto, 200, 200, seq_black_diag_slidein, seq_black_fadeout],
				[fun_cut_textbox, "test trans 1"],
			]
			break
			
		}
		
	}

}

 #endregion this is where all the textbox stuff is
#region music

function fun_cut_over_mus(_mus = -1, _time_sec = 0, _tex_mus = array_create(5, -1), _pos = 0) {
	
	fun_play_over_mus(_mus, _time_sec, _tex_mus ,_pos)
	fun_cut_end()
	
}

function fun_cut_tex_mus(_mus = -1, _time_sec = 0) {
	
	fun_play_tex_music(_mus, _time_sec)
	fun_cut_end()
	
}

#endregion music
#region data based on player
 
 function fun_player_colour(_player = GAME_CURPLAYER) {
	
	switch(_player) {
		
		case PLAYERS.DRAC:	return C_DRAC
		case PLAYERS.KATE:	return C_KATE
		case PLAYERS.MUD:	return C_MUD
		case PLAYERS.FEVIR:	return C_FEV
		case PLAYERS.JAB:	return C_JAB
		
	}
	
 }
 
 function fun_player_textbox(_player = GAME_CURPLAYER) {
	
	switch(_player) {
		
		case PLAYERS.DRAC: return	spr_textbox_drac
		case PLAYERS.KATE: return	spr_textbox_kate
		case PLAYERS.MUD: return	spr_textbox_mud
		case PLAYERS.FEVIR: return	spr_textbox_fevir
		case PLAYERS.JAB: return	spr_textbox_jab
		
	}
	
 }
 
 function fun_player_font(_player = GAME_CURPLAYER) {
	
	switch(_player) {
		
		case PLAYERS.DRAC: return	FNT_DRAC
		case PLAYERS.KATE: return	FNT_DRAC
		case PLAYERS.MUD: return	FNT_DRAC
		case PLAYERS.FEVIR: return	FNT_DRAC
		case PLAYERS.JAB: return	FNT_DRAC
		
	}
	
 }
 
 #endregion data based on player
#region greek and not greek
 
function fun_level_to_glyph(_lvl) {
	
	return string_char_at("-αβγδεζηθικλμνξoπρστυφχψΩ!", _lvl+1)
	
 }
 
function fun_level_to_title(_lvl) {
	
	var _titles = [
		"Hatchling",
		"Alpha",
		"Beta",
		"Gamma",
		"Delta",
		"Epsilon",
		"Zeta",
		"Eta",
		"Theta",
		"Iota",
		"Kappa",
		"Lambda",
		"Mu",
		"Nu",
		"Xi",
		"Omicron",
		"Pi",
		"Rho",
		"Sigma",
		"Tau",
		"Upsilon",
		"Phi",
		"Chi",
		"Psi",
		"Omega",
		"Giga",
	]
	
	return _lvl > 25 ? "???" : _titles[_lvl]
	
}

function fun_elem_to_string(_elem, _fuck_you_dont_change_this = ["Blunt", "Fire", "Ice", "Poison", "Life", "Elec", "Rad", "Decay"]) {
	
	return _fuck_you_dont_change_this[_elem]
	
}

//show_message(string_length("-αβγδεζηθικλμνξoπρστυφχψΩ!"))

#endregion greek