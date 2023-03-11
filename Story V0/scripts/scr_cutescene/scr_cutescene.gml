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
 
 function fun_cut_object_move_tween(_id, _x, _y, _spd, _relative = false) {
	
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
		
		if (event_number == 0) then {
			
			with obj_camera { if !surface_exists(trans_surf) then trans_surf = surface_create(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) }
			surface_set_target(obj_camera.trans_surf)
			draw_clear_alpha(c_white, 0)
			
		}
		
	}
	
}

function fun_layer_surface_unset() {
	
	if (event_type == ev_draw) then {
		
		if (event_number == 0) then {
			
			surface_reset_target()
			
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
 
 function fun_cut_change_room(_room, _playerx, _playery, _in, _out, _battle_id = "") {
	
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
 
 #endregion change rooms
 #region this is where all the textbox stuff is
 
 
 
 #endregion this is where all the textbox stuff is
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
 #region greek
 
 function fun_level_to_glyph(_lvl) {
	
	return string_char_at("-αβγδεζηθικλμνξoπρστυφχψΩ!", _lvl)
	
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
		"Over",
	]
	
	return _lvl > 25 ? "???" : _titles[_lvl]
	
}
 
 //show_message(string_length("-αβγδεζηθικλμνξoπρστυφχψΩ!"))
 
 #endregion greek