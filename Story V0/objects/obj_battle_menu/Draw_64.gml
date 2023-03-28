draw_text(0, 0, state)

draw_set_font(font)

var _cplayer = GAME_CURPLAYER

if (page != page_prev) then {
	pos = 0
	page_prev = page
}

//draw flavor text back
draw_sprite_stretched_ext(sprite_index, image_index, box_x-bord, box_y-bord, box_w+bord2, box_y+bord2, image_blend, image_alpha)

//draw opts back
draw_sprite_stretched_ext(sprite_index, image_index, opts_x-bord, opts_y-bord, opts_w+bord2, opts_y+bord2, image_blend, image_alpha)

//draw options
var _length = array_length(book[page])
var _zlength = _length - 1
var i = ( pos == 0 ? 0 : ( pos == _zlength ? _zlength-2 : pos-1 ) )
var j = 0
var _cur_text = -1
repeat(3) {
	
	_cur_text = is_array(book[page][i]) ? book[page][i][1] : book[page][i]
	
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

switch(state) {//state machine 
	
	case 0:
	#region base menu
	
	pos = clamp(pos + (key_down - key_up), 0, _zlength)
	
	if (key_enter) then {
		switch(book[page][pos]){
			case "Act": page = 1 break
			case "Skill": page = 2 break
			case "Item": page = 3 break
		}
	}
	
	#endregion base menu
	break
	
}

draw_set_font(-1)