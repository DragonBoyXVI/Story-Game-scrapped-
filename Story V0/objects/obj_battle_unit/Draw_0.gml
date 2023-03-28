
if (in_water) then
	fun_draw_self_water()
else
	draw_self()


draw_text(x, y, name)
draw_text(x, y+16, string("HP: {0}/{1}", stat_hp, stat_hp_max))
draw_text(x, y+32, string("AP: {0}", ap))