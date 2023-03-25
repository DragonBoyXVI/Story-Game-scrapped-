
draw_set_font(font)

//draw flavor text back
draw_sprite_stretched_ext(sprite_index, image_index, box_x-bord, box_y-bord, box_w+bord2, box_y+bord2, image_blend, image_alpha)

//draw opts back
draw_sprite_stretched_ext(sprite_index, image_index, opts_x-bord, opts_y-bord, opts_w+bord2, opts_y+bord2, image_blend, image_alpha)

draw_set_font(-1)