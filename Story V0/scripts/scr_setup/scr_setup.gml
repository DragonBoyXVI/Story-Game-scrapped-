
randomize()

#macro ANIM_LAYER_NAME ("anim")
#macro NONE (-1)

#region game data and macs

global.water_height = 32

global.stored_coords = [-1, -1]
global.stored_room = -1

global.in_trans = false
global.stored_trans = -1

global.battle_before_room = -1
global.battle_id = undefined

global.enemy_level = [0, 3]

global.tex_music = array_create(BEASTS.JAB, -1)

global.tex_music_boss = [-1]

global.yscale = 1
#macro YSCALE (global.yscale)

global.game = {
	
	save_path: "",
	
	rng: [], //array_create(100, -1),
	rng_pos: 0,
	
	#region flags
	
	flags: [],
	
	#endregion flags
	#region player data
	
	data_drac: {
		
		exp_points: 0,
		exp_next_level: fun_get_exp(1),
		level: 0,
		
		rads: 0,
		
		has_me: true,
		
		hp: 8,
		hp_max: 8,
		
		stam: 10,
		stam_regen: 15,
		
		spd: 8,
		
		str: 1,
		mag: 6,
		
		items: [],
		
	},
	
	cur_player : 0,
	
	#endregion player data
	
	mods: {
		
		rng_table: true,
		exp_mult: 1,
		foe_scale: 1,
		
		active_combat: true,
		active_div: 5,
		
		mod_mods: true,
		
	},
	
}
#macro GAME (global.game)
#macro GAME_CURPLAYER (global.game.cur_player)

#macro GAMEMOD_RNG_TABLE (global.game.mods.rng_table)
#macro GAMEMOD_EXP (global.game.mods.exp_mult)
#macro GAMEMOD_ENEMY_SCALE (global.game.mods.foe_scale)

#macro GAMEMOD_ACTIVE_COMBAT (global.game.mods.active_combat)
#macro GAMEMOD_ACTIVE_DIV (global.game.mods.active_div)

#macro GAMEMOD_MODMOD (global.game.mods.mod_mods)

global.settings = {
	
	shader_on: true,
	
	draw_rounded: false,
	show_time_as: 0, //0 = seconds, 1 = frames
	
	show_mouse: true,
	
	gain_music: 1,
	gain_sfx: 1,
	
	app_surf_div: 3,
	
}
#macro SETTINGS_SHADER (global.settings.shader_on)
#macro SETTINGS_DRAW_ROUND (global.settings.draw_rounded)
#macro SETTINGS_DRAW_FRAMES (global.settings.show_time_as)

#macro SETTINGS_DRAW_MOUSE (global.settings.show_mouse)

#macro SETTINGS_GAIN_MUS (global.settings.gain_music)
#macro SETTINGS_GAIN_SFX (global.settings.gain_sfx)

#macro SETTINGS_APP_SURF_DIV (global.settings.app_surf_div)



#endregion game data and macs
#region enums

enum PLAYERS {
	
	DRAC,
	KATE,
	MUD,
	FEVIR,
	JAB,
	
}

enum BEASTS {
	
	//players
	DRAC,
	KATE,
	MUD,
	FEVIR,
	JAB,
	
	//test
	SHRUB,
	
	ALLBEASTS,
	
}

enum STATES {
	
	//player
	PLAY,
	IDLE,
	
	SPEC,
	
	SP_DRAC_BULLET,
	SP_DRAC_JUMP,
	
	SP_MUD_STEALTH,
	
	//camera
	FOLLOW_POS,
	FOLLOW_OBJ,
	
}

enum FACES {
	
	RIGHT,
	UP,
	LEFT,
	DOWN,
	
}

enum ELEMENT {
	
	BLUNT,
	FIRE,
	ICE,
	POISON,
	LIFE,
	ELEC,
	DECAY,
	RAD,
	
	GARBO,
	
}

enum MOVES {
	
	//basic
	MELEE_ATK,
	RANGE_ATK,
	REST,
	DEFEND,
	USE_ITEM,
	
	//drac
	NEEDLE,
	HEAL,
	DUNDER,
	
	
}

enum BULLETS {
	
	NEEDLE,
	
}

#endregion enums
#region map keys

keyboard_set_map(ord("W"), vk_up)
keyboard_set_map(ord("A"), vk_left)
keyboard_set_map(ord("S"), vk_down)
keyboard_set_map(ord("D"), vk_right)

keyboard_set_map(ord("Z"), vk_enter)
keyboard_set_map(ord("X"), vk_backspace)

#endregion map keys
#region set models

audio_falloff_set_model(audio_falloff_exponent_distance)

#endregion set models
#region audio effects

var _eff_reverb = audio_effect_create(AudioEffectType.Reverb1)

_eff_reverb.mix = 0.5
_eff_reverb.size = 0.5
_eff_reverb.bypass = true

audio_bus_main.effects[0] = _eff_reverb


var _eff_delay = audio_effect_create(AudioEffectType.Delay)

_eff_delay.mix = 0.5
_eff_delay.feedback = 0.15
_eff_delay.time = 0.5
_eff_delay.bypass = true

audio_bus_main.effects[1] = _eff_delay


var _eff_lowpass = audio_effect_create(AudioEffectType.LPF2)

_eff_lowpass.bypass = true

audio_bus_main.effects[2] = _eff_lowpass


var _eff_highpass = audio_effect_create(AudioEffectType.HPF2)

_eff_highpass.bypass = true

audio_bus_main.effects[3] = _eff_highpass


var _eff_bit = audio_effect_create(AudioEffectType.Bitcrusher)

_eff_bit.mix = 1
_eff_bit.resolution = 16
_eff_bit.factor = 10
_eff_bit.bypass = true

audio_bus_main.effects[4] = _eff_bit

#endregion audio effects
#region set music loops										tempo * (bars * beats)
audio_channel_num(50)

audio_sound_loop_start(		snd_battle_test,				time_bpm_to_seconds(155) * (9 * 3))
audio_sound_loop_end(		snd_battle_test,				time_bpm_to_seconds(155) * (111 * 3))

audio_sound_loop_start(		snd_battle_test_drac,			time_bpm_to_seconds(155) * (9 * 3))
audio_sound_loop_end(		snd_battle_test_drac,			time_bpm_to_seconds(155) * (111 * 3))

audio_sound_loop_start(		snd_over_test,					time_bpm_to_seconds(123) * (5 * 4))
audio_sound_loop_end(		snd_over_test,					time_bpm_to_seconds(123) * (25 * 4))

audio_sound_loop_start(		snd_mus_battle_fevir_test,		time_bpm_to_seconds(145) * (1 * 4))
audio_sound_loop_end(		snd_mus_battle_fevir_test,		time_bpm_to_seconds(145) * (46 * 4))

#endregion set music loops
#region colors and fonts

function fun_string_reverse(_string) {
	
	var _new = ""
	
	var i = string_length(_string)
	repeat(i) {
		
		_new += string_char_at(_string, i)
		
		i--
		
	}
	
	return _new
	
}

var _mapstring = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()`-=[];',./\\~_+{}:\"<>?|αβγδεζηθικλμνξπρστυφχψΩ"
// use regular o for omicron

_mapstring = fun_string_reverse(_mapstring)

global.fnt_drac = font_add_sprite_ext(spr_drac_font, _mapstring, true, 2)
#macro FNT_DRAC (global.fnt_drac)

#macro FNT_KATE (-1)

#macro FNT_MUD (-1)

#macro FNT_FEVIR (-1)

#macro FNT_JAB (-1)


global.c_drac = make_color_rgb(39,141,35)
#macro C_DRAC (global.c_drac)

global.c_mud = make_color_rgb(52,45,16)
#macro C_MUD (global.c_mud)

global.c_kate = make_color_rgb(0,155,255)
#macro C_KATE (global.c_kate)

global.c_fevir = make_color_rgb(255,155,0)
#macro C_FEV (global.c_fevir)

global.c_jab = make_color_rgb(155,155,155)
#macro C_JAB (global.c_jab)


global.c_poison = make_colour_rgb(93, 18, 42)
#macro C_POISON (global.c_poison)

global.c_life = make_colour_rgb(4, 100, 26)
#macro C_LIFE (global.c_life)

#endregion colors and fonts
#region particles

global.part_sys = part_system_create()
part_system_depth(global.part_sys, -9990)

#region poison

var _poi_type = part_type_create()
part_type_shape(_poi_type, pt_shape_cloud)
part_type_scale(_poi_type, 1, 1)
part_type_size(_poi_type, 0.25, 1, 0.01, 0)
part_type_speed(_poi_type, 0.5, 0.8, -0.001, 0.0005)
part_type_direction(_poi_type, 0, 360, 0, 0.01)
part_type_orientation(_poi_type, 0, 360, 0, 0, true)
part_type_color1(_poi_type, C_POISON)
part_type_alpha2(_poi_type, 1, 0)
part_type_life(_poi_type, 50, 100)

global.poison_type = _poi_type


#endregion poison

#endregion particles