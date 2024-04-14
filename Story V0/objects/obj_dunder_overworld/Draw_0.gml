
switch(state) {
	
	default: draw_self() break
	
	case 2:
	case 3:
	case 4:
	draw_sprite_ext(spr_dunder_under, 0, x, y, 1, image_yscale, 0, c_white, image_alpha * 0.75)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)
	break
	
}

draw_text(x, y, state)