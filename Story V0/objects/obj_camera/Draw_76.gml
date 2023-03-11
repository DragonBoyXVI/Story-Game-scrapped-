
//global.settings.shader_on = keyboard_check(ord("L"))

if (SETTINGS_SHADER) then {
	
	shader_set(shd_replace_blackwhite)
	shader_set_uniform_f_array(shader_uniform_color, blend_color)
	shader_set_uniform_f(shader_uniform_percent, blend_amt)
	
	//show_message(blend_color)
	
}