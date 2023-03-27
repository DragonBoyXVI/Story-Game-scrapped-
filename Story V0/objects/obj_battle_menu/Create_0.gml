//states, 0 = normal, 1 = target a unit, 2 = target a fairy


font = fnt_test
color = GAME_CURPLAYER == PLAYERS.KATE or GAME_CURPLAYER == PLAYERS.FEVIR ? c_white : c_black
color_sele = color == c_black ? c_white : c_black

lines = 3 //how many line up from the bottom can we have? this cannot be changed dynamicly



switch(actor.beast_id) {
	
	default:
	sprite_index = fun_player_textbox()
	color_sele = fun_player_colour()
	font = fun_player_font()
	break
	
}

switch(state) {
	
	case 0:
	#region choosing a skill
	
	book[0] = [//base menu
		"Act",
		"Skill",
		"Item",
	]
	
	book[1] = []//act menu
	array_copy(book[1], 0, actor.moveset_basic, 0, array_length(actor.moveset_basic))
	array_push(book[1], "Back")
	
	book[2] = []//skill menu
	array_copy(book[2], 0, actor.moveset_skills, 0, array_length(actor.moveset_skills))
	array_push(book[2], "Back")
	
	book[3] = []//item menu
	array_copy(book[3], 0, actor.pocket_items, 0, array_length(actor.pocket_items))
	array_push(book[3], "Back")
	
	#endregion choosing a skill
	break
	
}


bord = 16
bord2 = 32

sep = 32

var _gui_w = display_get_gui_width()
var _gui_h = display_get_gui_height()

opts_x = 0
opts_y = _gui_h - (32 * lines)
opts_w = _gui_w/6
opts_h = 32 * lines

box_x = opts_w + 32
box_y = opts_y
box_w = _gui_w - opts_w
box_h = opts_h


key_up = false
key_down = false
key_left = false
key_right = false

key_enter = false
key_backspace = false

page_prev = -1
page = 0
pos = 0