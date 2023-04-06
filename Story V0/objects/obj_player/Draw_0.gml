
if (in_water) then {
	
	fun_draw_self_water()
	
} else {
	
	draw_self()
	
}

draw_sprite_stretched(spr_pix_hollow, 0, bbox_left, bbox_top, bbox_right-bbox_left, bbox_bottom-bbox_top)