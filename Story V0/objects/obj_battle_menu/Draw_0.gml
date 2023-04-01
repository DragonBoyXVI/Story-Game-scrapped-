
var _me = book[page][pos]

if (is_real(_me) and instance_exists(_me)) then {
	draw_sprite_ext(spr_pencil, GAME_CURPLAYER, _me.x, _me.y, 1, 1, 180, c_white, 1)
}