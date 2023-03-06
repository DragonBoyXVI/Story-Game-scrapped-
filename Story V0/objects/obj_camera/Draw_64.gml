draw_text(0, 0, string("Yscale: {0}", YSCALE))
draw_text(0, 16, string("Cur: {0} Tween: {1}", lens_current, lens_tween))
draw_text(0, 32, global.game.rng)
draw_text(0, 48, instance_count)

draw_text(0, 64, string("{0} {1}", mus, mus == -1 ? 0 : audio_sound_get_track_position(mus)))
draw_text(0, 80, [loop_end, loop_sub])

//global.yscale += 0.01 * (keyboard_check(ord("0")) - keyboard_check(ord("9")))