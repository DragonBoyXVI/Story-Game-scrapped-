
do_setup = true

page_prev = -1
page = 0
page_number = 0
charpos = 0
charfloor = 0
pos = 0

typing = false

key_up = false
key_down = false
key_enter = false

soundpos = 0

charwait = 0

#region arrays

text = []
text_color = []

text_length = []

#region effects (thanks Peyton!)

char = [] //2d
char_x = []
char_y = []

line_break_pos = []
line_break_num[page_number] = 0
line_break_off[page_number] = 0
last_free_space = 0

#endregion effects

font = []

header = []
header_color = []

head_x = []//0
head_y = []//0
head_w = []//0
head_h = []//32

options = [] //will be an array if this has ops, [text, new scene id, otherwise -1]
option_color_sele = []

opts_length = 0

opts_x = 0
opts_y = 0
opts_w = 0
opts_h = 0

bust_talk = []
bust_idle = [] //checked for when using busts

bust_side_right = []
bust_face_right = []

bust_xscale = 1

sound = []
sound_once = []
sound_played = false

box_sprite = []

spd = []

bust_speed_idle = 0
bust_speed_talk = 0

bust_image = 0

bust_loop_idle = 0
bust_loop_talk = 0

sep = 32
bord = 16
bord2 = 32

box_x = []//0
box_y = []//0
box_w = []//0
box_h = []//32

#endregion arrays