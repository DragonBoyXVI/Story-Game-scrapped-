
if (in_water) then
	fun_draw_self_water()
else
	draw_self()


draw_text(x, y, name)
draw_text(x, y+16, string("HP: {0}/{1}", stat_hp, stat_hp_max_real))
draw_text(x, y+32, string("STAM: {0}/{1}", stat_stam, stat_stam_max))
draw_text(x, y+48, string("AP: {0}", ap))
draw_text(x, y+64, [spd_built, selected_move])