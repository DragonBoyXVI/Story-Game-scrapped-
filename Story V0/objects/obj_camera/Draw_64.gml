draw_text(0, 0, string("Yscale: {0}", YSCALE))
draw_text(0, 16, string("Cur: {0} Tween: {1}", lens_current, lens_tween))
draw_text(0, 32, instance_count)

if mus_cur != -1 then 
	draw_text(0, 48, audio_sound_get_track_position(mus_cur))

draw_text(0, 64, global.game.rng)

//global.yscale += 0.01 * (keyboard_check(ord("0")) - keyboard_check(ord("9")))