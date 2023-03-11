
draw_sprite_stretched_ext(spr_pix, 0, 0, 0, gui_w, gui_h, c_black, 0.25)

//cursor_sprite = spr_pencil

key_up =		keyboard_check_pressed(vk_up)
key_down =		keyboard_check_pressed(vk_down)
key_left =		keyboard_check_pressed(vk_left)
key_right =		keyboard_check_pressed(vk_right)
key_enter =		keyboard_check_pressed(vk_enter)
key_backspace =	keyboard_check_pressed(vk_backspace)

draw_set_font(box_font)

//update the page
if (page_update) then {
	
	pos = 0
	
	box_font = fun_player_font()
	draw_set_font(box_font)
	
	box_w = -1
	page_length = array_length(book[page])
	var i = 0, _length = -1
	repeat(page_length) {
		
		_length = string_width(book[page][i])
		box_w = _length > box_w ? _length : box_w
		
		i++
		
	}
	
	box_h = (sep * page_length)
	
	switch(GAME_CURPLAYER) {
		
		case PLAYERS.DRAC:
		colour = c_black
		colour_sele = C_DRAC
		break
		
	}
	
	page_update = false
	sprite_index = fun_player_textbox()
	
}

pos += (key_down - key_up)
pos = pos >= page_length ? 0 : pos
pos = pos < 0 ? page_length-1 : pos

draw_text(0, 0, string("{0} {1}", pos, page_length))

//draw the back sprite
draw_sprite_stretched_ext(sprite_index, image_index, box_x-bord, box_y-bord, box_w+bord2, box_h+bord2, c_white, 1)

//draw the text
var i = 0
repeat(page_length) {
	
	if (i == pos) then {
		
		draw_text_ext_color(box_x, box_y+(sep*i), book[page][i], sep, box_w, colour_sele, colour_sele, colour_sele, colour_sele, 1)
		draw_sprite_ext(spr_pencil, GAME_CURPLAYER, box_x-bord, box_y+16+(sep*i), 1, 1, 0, c_white, 1)
		
	} else {
		
		draw_text_ext_color(box_x, box_y+(sep*i), book[page][i], sep, box_w, colour, colour, colour, colour, 1)
		
	}
	
	i++
	
}

//draw the lower box
draw_sprite_stretched_ext(sprite_index, image_index, bottom_x-bord, bottom_y-bord, bottom_w+bord2, bottom_h+bord2, c_white, 1)

//draw text based on selection (and enter key too)

var _text = ""
switch(book[page][pos]) {
	
	#region main
	
	case "Resume":
	_text = "Resume right where you left off."
	
	if (key_enter) then key_pause = true
	break
	
	case "Settings":
	_text = "Change some game settings."
	break
	
	case "Modifiers":
	_text = string("Look at or change some game modifiers. {0}", change_mods ? "Mods can be changed now." : "Mods cannot be changed.")
	break
	
	case "Inventory":
	_text = string("Look at your items or the beastiary. {0}", has_menu ? "" : "(Cannot be used now.)")
	break
	
	case "Last Saved Time":
	_text = string("No previous save data.")
	break
	
	case "Exit to Main Menu":
	_text = "There is no main menu, this will close the game."
	
	if key_enter then game_end()
	
	break
	
	#endregion main
	
}

if (override > 0) then {
	
	draw_text_ext_color(bottom_x, bottom_y, text_override, sep, bottom_w, colour, colour, colour, colour, 1)
	override--
	
} else {
	
	draw_text_ext_color(bottom_x, bottom_y, _text, sep, bottom_w, colour, colour, colour, colour, 1)
	
}

draw_set_font(-1)