//draw_text(0, 0, [fps, fps_real])
//draw_text(0, 0, [mus == -1 ? -1 : audio_sound_get_track_position(mus), mus_tex == -1 ? -1 : audio_sound_get_track_position(mus_tex)])

//draw_text(0, 0, room_persistent)
/*

draw_text(0, 0, string("Yscale: {0}", YSCALE))
draw_text(0, 16, string("Cur: {0} Tween: {1}", lens_current, lens_tween))
draw_text(0, 32, global.game.rng)
draw_text(0, 48, instance_count)

draw_text(0, 64, [x, y])

//global.yscale += 0.01 * (keyboard_check(ord("0")) - keyboard_check(ord("9")))