if ai_ctrl then exit //use end step to handle AI

draw_set_font(font)

var _cplayer = GAME_CURPLAYER

if (page != page_prev) then {
	pos = 0
	page_prev = page
}

//draw flavor text back

draw_sprite_stretched_ext(sprite_index, image_index, box_x-bord, box_y-bord, box_w+bord2, box_y+bord2, image_blend, image_alpha)

var _draw = draw_text_ext_color

var _place = book[page][pos]
switch(page) {
	
	case 0:
	if pos == 0 then _draw(box_x, box_y, "Acts", sep, box_w, color, color, color, color, 1)
	else if pos == 1 then _draw(box_x, box_y, "Skillsz", sep, box_w, color, color, color, color, 1)
	else if pos == 2 then _draw(box_x, box_y, "Dick in yo pocket foo", sep, box_w, color, color, color, color, 1)
	break
	
	case 1:
	if is_string(_place) then {_draw(box_x, box_y, "Cancel this", sep, box_w, color, color, color, color, 1)}
	else _draw(box_x, box_y, _place[2], sep, box_w, color, color, color, color, 1)
	break
	
	case 2:
	break
	
	default:
	_draw(box_x, box_y, menu_message[times_to_edit], sep, box_w, color, color, color, color, 1)
	break
	
}

//draw opts back
draw_sprite_stretched_ext(sprite_index, image_index, opts_x-bord, opts_y-bord, opts_w+bord2, opts_y+bord2, image_blend, image_alpha)

//draw options
var _length = array_length(book[page])
var _zlength = _length - 1
var i = ( pos == 0 ? 0 : ( pos == _zlength ? _zlength-2 : pos-1 ) )
var j = 0
var _cur_text = -1
var _now = 0
repeat(clamp(array_length(book[page]), 0, 3)) {
	
	_now = book[page][i]
	
	if is_string(_now) then _cur_text = _now
	else if is_array(_now) then _cur_text = _now[1]
	else if instance_exists(_now) then _cur_text = _now.name
	
	if (pos == i) then {
		draw_text_color(opts_x, opts_y+(sep*j), _cur_text, color_sele, color_sele, color_sele, color_sele, 1)
		draw_sprite_ext(spr_pencil, _cplayer, opts_x-bord, opts_y+(sep*j), 1, 1, 0, c_white, 1)
	} else {
		draw_text_color(opts_x, opts_y+(sep*j), _cur_text, color, color, color, color, 1)
	}
	
	i++
	j++
	
}
if (pos + 1 < _zlength) then {
	draw_sprite_ext(spr_pencil, _cplayer, opts_x+opts_w+bord, opts_y+(sep*3), 0.75, 0.75, 270, c_white, 1)
}
if (pos - 1 > 0 and _length > 2) then {
	draw_sprite_ext(spr_pencil, _cplayer, opts_x+opts_w+bord, opts_y, 0.75, 0.75, 90, c_white, 1)
}


//actual menu
pos = clamp(pos + (key_down - key_up), 0, _zlength)

var _cur_choice = book[page][pos]

switch(page) {
	
	case 0:
	#region go to other menus
		
		if key_enter then {
			
			switch(_cur_choice){
				case "Act": page = 1 break
				case "Skill": page = 2 break
				case "Item": page = 3 break
			}
			
		}
		
		#endregion go to other menus
	break
	
	case 1:
	#region the acts menu
	
	if key_backspace then {
		page = 0
		break
	}
	
	if key_enter then {
		
		if is_string(_cur_choice) then {
			page = 0
		} else {
			
			
			
		}
		
	}
	
	#endregion the acts menu
	break
	
}

draw_set_font(-1)