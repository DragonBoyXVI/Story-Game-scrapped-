
/*
if (highlight_me) then {
	var _width_2 = sprite_width/2
	draw_sprite_stretched_ext(sprite_index, image_index, x-_width_2-highlight_pix, y-sprite_height-highlight_pix, sprite_width+highlight_pix, sprite_height+highlight_pix, highlight_col, 1)
}
*/

if (in_water) then
	fun_draw_self_water()
else
	draw_self()


draw_text(x, y, name)
draw_text(x, y+16, string("HP: {0}/{1}", stat_hp, stat_hp_max_real))
draw_text(x, y+32, string("STAM: {0}/{1}", stat_stam, stat_stam_max))
draw_text(x, y+48, string("AP: {0}", ap))
draw_text(x, y+64, [spd_built, selected_move])