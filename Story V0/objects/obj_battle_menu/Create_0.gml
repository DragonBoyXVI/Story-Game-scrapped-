//states, 0 = normal, 1 = target a unit, 2 = target a fairy


font = fnt_test
color = GAME_CURPLAYER == PLAYERS.KATE or GAME_CURPLAYER == PLAYERS.FEVIR ? c_white : c_black
color_sele = color == c_black ? c_white : c_black

switch(actor.beast_id) {
	
	default:
	sprite_index = fun_player_textbox()
	color_sele = fun_player_colour()
	font = fun_player_font()
	break
	
}


lines = 4

bord = 16
bord2 = 32

sep = 32

var _gui_w = display_get_gui_width()
var _gui_h = display_get_gui_height()

opts_x = 0
opts_y = _gui_h - (32 * lines)
opts_w = _gui_w/6
opts_h = 32 * lines

box_x = opts_w
box_y = opts_y
box_w = _gui_w - opts_w
box_h = opts_h