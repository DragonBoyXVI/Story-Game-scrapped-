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

#region books i love books

stored_data = [] //move function, data, data

move_time_needed = -1 //time needed to pop move

times_to_edit = -1 //what edit are we currently on?
max_edits = -1 //how many times to edit
what_menu = [] //array of pages to look at
edit_index = [] //position in data to edit
menu_message = [] //what message to show
target_fucker_is_here_bool = [] //if true, save the current index
target_fucker_is_here_index = -1 //the index the taregt is at

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

book[4] = []//team players
book[4] = fun_list_to_array(obj_battle_manager.units[0])

book[5] = []//team foes
book[5] = fun_list_to_array(obj_battle_manager.units[1])

book[6] = []//team everyone
book[6] = array_concat(book[4], book[5])

array_push(book[4], "Back")
array_push(book[5], "Back")
array_push(book[6], "Back")

#endregion bookz


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
box_w = _gui_w - opts_w - 16
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

if (actor.is_boss) then {
	
	//do shit based on beast id
	
} else {
	
	switch(actor.beast_id) {
		
		default: fun_play_tex_music(-1, 0.5) break
		
		
		case BEASTS.DRAC: 
		case BEASTS.KATE: 
		case BEASTS.MUD: 
		case BEASTS.FEVIR: 
		case BEASTS.JAB: 
		fun_play_tex_music(global.tex_music[actor.beast_id], 0.5) break
		
	}
	
}