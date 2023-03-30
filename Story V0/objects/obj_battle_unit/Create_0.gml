
highlight_pix = 6
highlight_me = true

#region stats

ignore_me = false

level = 0

ap = 0
ap_speed = 2

rads = 0
immune_rads = false

stat_hp = 1
stat_hp_max = 1
stat_hp_max_real = 1

mod_hp = 0
immune_mod_hp = false

stat_stam = 1
stat_stam_max = 1
stat_stam_regen = 1

mod_stam = 0
immune_mod_stam = false

stat_spd = 1
stat_swim_spd = 1

spd_built = 0

mod_spd = 0
immune_mod_spd = false

stat_str = 1
stat_mag = 1

mod_str = 0
immune_mod_str = false
mod_mag = 0
immune_mod_mag = false

stat_arm_base = 1

stat_arm_elem = array_create(8, 1)

aim = 100
defense = 0

#endregion stats
#region define status effects

poisoned = 0
immune_poisoned = false

burning = 0
immune_burning = false

frozen = 0
immune_frozen = false

stun = 0
immune_stun = 0

acid = 0
immune_acid = false

base = 0
immune_base = 0

bleeding = 0
immune_bleeding = 0

stealth = 0
immune_stealth = 0

energy = 0
immune_energy = 0

tripped = 0
immune_tripped = false

asleep = false
immune_sleep = false

rebooting = false
immune_reboot = true

taunt = 0
immune_taunt = false

caut = 0
immune_caut = false

ap_instant = 0
mod_ap = 0

defending = 0

#endregion define status effects
#region racial traits

age = 0

colour = c_white

my_ai = undefined//function() {}

is_boss = false

beast_id = -1
name = string("No name {0}", instance_number(object_index))

enemy_team = false //yay i love using the not word =DDDDDDFDSD
ai_ctrl = false

selected_move = undefined //[ time needed, [the actual data to be evented], move name ]
needed_target = noone //move is canceled if the target no longer exists, noone means that no target is needed

is_human = false
is_dragon = false
is_naga = false
is_kobold = false
is_dog = false
is_cat = false
is_insect = false
is_aqua = false
is_protogen = false
is_synth = false

race_organic = false
race_robotic = false

can_fly = false
flying = false
in_water = false

has_gun = false
gun_clip = 0
gun_clip_max = 0

moveset_basic = []  //[id, name]
moveset_skills = []	//[id, name]
pocket_items = []	//[[use item move, item id], name, desc]

#endregion racial traits
#region data structures

menu_page_fairy = -1

list_fairy = ds_list_create()

struct_sprites = {
	
	idle: spr_test_idle,
	idle_low_hp: spr_test_idle_hurt,
	
	hurt_blunt: spr_test_hurt_blunt,
	
	attack_basic: spr_test_attack,
	special_anim: spr_pix,
	
}

#endregion data structures
#region traits

uni_toxic_blood = false

#endregion traits
#region water

var _layer = -1

if (layer_exists("Water")) then _layer = layer_get_id("Water")
if (layer_exists("water")) then _layer = layer_get_id("water")

if (_layer != -1) then {
	
	in_water = tilemap_get_at_pixel(layer_tilemap_get_id(_layer), x, y)
	
}

#endregion water