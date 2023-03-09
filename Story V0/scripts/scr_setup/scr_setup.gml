
randomize()

#region game data and macs

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
	
	#region flags
	
	flags: [],
	
	#endregion flags
	#region player data
	
	cur_player : 0,
	
	#endregion player data
	
	mods: {
		
		rng_table: true,
		
	},
	
}
#macro GAME_CURPLAYER (global.game.cur_player)

#macro GAMEMOD_RNG_TABLE (global.game.mods.rng_table)

global.settings = {
	
	shader_on: true,
	
	draw_rounded: false,
	
	gain_music: 0.75,//1,
	gain_sfx: 1,
	
}
#macro SETTINGS_SHADER (global.settings.shader_on)
#macro SETTINGS_DRAW_ROUND (global.settings.draw_rounded)
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

audio_sound_loop_start(		snd_battle_test,				time_bpm_to_seconds(155) * (9 * 3))
audio_sound_loop_end(		snd_battle_test,				time_bpm_to_seconds(155) * (111 * 3))

audio_sound_loop_start(		snd_battle_test_drac,			time_bpm_to_seconds(155) * (9 * 3))
audio_sound_loop_end(		snd_battle_test_drac,			time_bpm_to_seconds(155) * (111 * 3))

audio_sound_loop_start(		snd_over_test,					time_bpm_to_seconds(123) * (5 * 4))
audio_sound_loop_end(		snd_over_test,					time_bpm_to_seconds(123) * (25 * 4))

#endregion set music loops