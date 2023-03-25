
draw_text(0, 0, instance_count)
draw_text(0, 16, round_count)
draw_text(0, 32, cur_event)
draw_text(0, 48, [time_passed, time_passed/room_speed])
draw_text(0, 64, string("Events: {0}, Players: {1}, Enemies: {2}", ds_list_size(events), ds_list_size(units[0]), ds_list_size(units[1])))
