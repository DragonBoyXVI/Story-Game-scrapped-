text_override = ""
override = 0

paused = false
has_menu = false
change_mods = false

pause_buffer = -1
pause_surface = -1

stored_res_w = -1
stored_res_h = -1

cam_x = 0
cam_y = 0

key_pause = false //changed by the camera object
key_unpause = -1

gui_w = -1
gui_h = -1

box_sprite = -1
box_font = -1
colour = c_black
colour_sele = c_white

page_length = -1
pos = 0

var _width = display_get_gui_width()
var _height = display_get_gui_height()

box_x = _width/10
box_y = _height/10
box_w = -1
box_h = _height - (2 * box_y)

bottom_x = _width/10
bottom_y = _height - 128
bottom_w = _width - (2 * bottom_x)
bottom_h = _height - bottom_y

sep = 32
bord = 16
bord2 = 32

page = 0
page_update = true

book[0] = [//main
	
	"Resume",
	"Settings",
	"Modifiers",
	"Inventory",
	"Last Saved Time",
	"Exit to Main Menu",
	
]

book[1] = [//settings
	
	"Back",

]

book[2] = [//mods
	
	"Back",
	
]

book[3] = [//inventory base
	
	"Equip Party",
	"Beastiary",
	"Back",
		
]

book[4] = [//inventory equips
	
	"Back",
		
]
book[5] = [//inventory beasts
	
	"Back",
		
]

key_up = false
key_down = false
key_left = false
key_right = false

key_enter = false
key_backspace = false

//instance_deactivate_object(id)