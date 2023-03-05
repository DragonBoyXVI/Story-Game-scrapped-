
randomize()

#region game data and macs

global.in_battle = false

global.water_height = 32

global.stored_coords = [-1, -1]
global.stored_room = -1

global.battle_stored_room = -1
global.in_trans = false
global.stored_trans = -1

global.yscale = 1
#macro YSCALE (global.yscale)

global.game = {
	
	rng: [], //array_create(100, -1),
	rng_pos: 0,
	
	cur_player: 0,
	
	#region flags
	
	flags: [],
	
	#endregion flags
	#region player data
	
	
	#endregion player data
	
}
#macro GAME_CURPLAYER (global.game.cur_player)

global.settings = {
	
	shader_on: true,
	draw_rounded: false,
	
	gain_music: 1,
	gain_sfx: 1,
	
}
#macro SETTINGS_SHADER (global.settings.shader_on)
#macro SETTINGS_DRAW_ROUNDED (global.settings.draw_rounded)
#macro SETTINGS_GAIN_MUS (global.settings.gain_music)
#macro SETTINGS_GAIN_SFX (global.settings.gain_sfx)


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
	
	DRAC,
	KATE,
	MUD,
	FEVIR,
	JAB,
	
	ALLBEASTS,
	
}

enum STATES {
	
	//player
	PLAY,
	IDLE,
	TRANS,
	
	SP_DRAC_POISON,
	SP_DRAC_JUMP,
	
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
#region fonts and colours

var _mapstring = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()`-=[];',./\\~_+{}:\"<>?|αβγδεζηθικλμνξπρστυφχψΩ"
// use regular o for omicron

function fun_string_reverse(_string) {
	
	var _new_string = ""
	var i = string_length(_string)
	repeat(i) {
		
		_new_string = _new_string + string_char_at(_string, i)
		
		i--
		
	}
	
	return _new_string
	
}

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

#endregion fonts and colours