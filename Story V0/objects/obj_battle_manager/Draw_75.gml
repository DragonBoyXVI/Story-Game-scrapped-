
draw_text(0, 0, instance_count)
draw_text(0, 16, [round_count, framewait])
draw_text(0, 32, cur_event)
draw_text(0, 48, [time_passed, time_passed/room_speed])
draw_text(0, 64, string("Events: {0}, Players: {1}, Enemies: {2}", ds_list_size(events), ds_list_size(units[0]), ds_list_size(units[1])))
draw_text(0, 80, global.tex_music)
//draw_text(0, 64+16, [surface_get_width(application_surface), surface_get_height(application_surface)])