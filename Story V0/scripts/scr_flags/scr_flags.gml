
function fun_check_flag(_index) {
	
	return global.game.flags[_index]
	
}

function fun_set_flag(_index, _value, _relative = false) {
	
	global.game.flags[_index] = _relative ? global.game.flags[_index] + _value : _value
	
	return global.game.flags[_index]
	
}