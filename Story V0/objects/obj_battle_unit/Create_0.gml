
#region stats

stat_hp = 1
stat_hp_max = 1
stat_hp_max_real = 1

stat_stam = 1
stat_stam_max = 1
stat_stam_regen = 1

stat_spd = 1

stat_str = 1
stat_mag = 1

stat_arm_base = 1

stat_arm_elem = array_create(8, 1)

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

#endregion define status effects
#region racial traits

beast_id = -1
name = string("No name {0}", instance_number(object_index))

enemy_team = false //yay i love using the not word =DDDDDDFDSD
ai_ctrl = false

is_human = false
is_dragon = false
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
in_water = false

has_gun = false
gun_clip = 0
gun_clip_max = 0

#endregion racial traits
#region data structures

list_fairy = ds_list_create()

struct_sprites = {
	
	idle: spr_test_idle,
	idle_low_hp: spr_test_idle_hurt,
	
	hurt_blunt: spr_test_hurt_blunt,
	
	attack_basic: spr_test_attack,
	
}

#endregion data structures