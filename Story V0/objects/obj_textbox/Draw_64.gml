
draw_set_font(font[page])

//update
if (page_prev != page) then {
	
	pos = 0
	charpos = 0
	charlength = string_length(text[page])
	soundpos = 0
	typing = true
	sound_played = false
	
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()
	#region check and set busts
	
	if (bust_idle[page] != -1) then {
		
		bust_xscale = bust_face_right[page] == bust_side_right[page] ? -1 : 1
		
		bust_speed_idle = sprite_get_speed(bust_idle[page])/game_get_speed(gamespeed_fps)
		bust_speed_talk = sprite_get_speed(bust_talk[page])/game_get_speed(gamespeed_fps)
		
		bust_loop_idle = sprite_get_number(bust_idle[page])
		bust_loop_talk = sprite_get_number(bust_talk[page])
		
		box_x = _width/8
		box_y = _height - 128
		box_w = _width - (2 * box_x)
		box_h = _height - box_y
		
	} else {
		
		box_x = _width/6
		box_y = _height - 128
		box_w = _width - (2 * box_x)
		box_h = _height - box_y
		
	}
	
	#endregion check and set busts
	
	sprite_index = box_sprite[page]
	
	if ((page-1) >= 0 and sound[page-1] != -1) then {
		audio_stop_sound(sound[page-1])
	}
	
	if (header[page] != -1) then {
		
		var _w = string_width(header[page])
		
		head_x = (_width/2) - (_w/2)
		head_w = _w
		head_y = box_y-48
		
	}
	
	opts_length = options[page] == -1 ? 0 : array_length(options[page])
	
	if (opts_length > 0) then {
		
		//show_message(options)
		
		//set width
		var i = 0, _nw = 0
		repeat(opts_length) {
			
			_nw = string_width(options[page][i][0])
			
			opts_w = _nw > opts_w ? _nw : opts_w
			
			i++
			
		}
		
		opts_x = (_width/2) - (opts_w/2)
		opts_y = header[page] == -1 ? box_y - (48*opts_length) : head_y - (48*opts_length)
		opts_h = sep * opts_length
		
	}
	
	page_prev = page
	
}

//draw bust
if (bust_idle[page] != -1) then {
	
	if (typing) then {
		
		draw_sprite_ext(bust_talk[page], bust_image, box_x, box_y, bust_xscale, 1, 0, c_white, 1)
		bust_image = bust_image > bust_loop_talk ? 0 : bust_image + bust_speed_talk
		
	} else {
		
		draw_sprite_ext(bust_idle[page], bust_image, box_x, box_y, bust_xscale, 1, 0, c_white, 1)
		bust_image = bust_image > bust_loop_talk ? 0 : bust_image + bust_speed_idle
		
	}
	
}

//draw back sprite
draw_sprite_stretched_ext(sprite_index, image_index, box_x-bord, box_y-bord, box_w+bord2, box_h+bord2, image_blend, image_alpha)

//draw text
var _c = text_color[page]
draw_text_ext_color(box_x, box_y, string_copy(text[page], 1, charfloor), sep, box_w, _c, _c, _c, _c, 1)

//header
if (header[page] != -1) then {
	
	_c = header_color[page]
	draw_sprite_stretched_ext(sprite_index, image_index, head_x-bord, head_y-bord, head_w+bord2, head_h+bord2, image_blend, image_alpha)
	draw_text_color(head_x, head_y, header[page], _c, _c, _c, _c, 1)
	
}

//options
if (options[page] != -1 and not typing) then {
	
	draw_sprite_stretched_ext(sprite_index, image_index, opts_x-bord, opts_y-bord, opts_w+bord2, opts_h+bord2, image_blend, image_alpha)
	var i = 0, _cs = option_color_sele[page]
	repeat(opts_length) {
		
		if (pos == i) then {
			
			draw_sprite_ext(spr_pencil, GAME_CURPLAYER, opts_x-bord, opts_y + (sep*i) + 16, 1, 1, 0, c_white, 1)
			draw_text_color(opts_x, opts_y + (sep*i), options[page][i][0], _cs, _cs, _cs, _cs, 1)
			
		} else {
			
			draw_text_color(opts_x, opts_y + (sep*i), options[page][i][0], _c, _c, _c, _c, 1)
			
		}
		
		i++
		
	}
	
}

draw_set_font(-1)