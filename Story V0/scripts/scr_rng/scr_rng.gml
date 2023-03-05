
function fun_init_rng() {
	
	var _file = file_text_open_read("RNG/RNG_table_base.txt")
	
	global.game.rng = []
	
	while (not file_text_eof(_file)) {
		
		array_push(global.game.rng, real( file_text_readln(_file) ))
		
	}
	
	global.game.rng = array_shuffle(global.game.rng)
	
	file_text_close(_file)
	
}

function fun_draw_rng(_scale = 1) {
	
	var _drawn = global.game.rng[global.game.rng_pos]
	
	global.game.rng_pos = ( global.game.rng_pos + 1 > array_length(global.game.rng) ? 0 : global.game.rng_pos + 1 )
	
	return _drawn * _scale
	
}

