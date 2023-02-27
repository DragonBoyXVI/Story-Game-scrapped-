
if (SETTINGS_SHADER) then {
	
	shader_set(shd_replace_blackwhite)
	shader_set_uniform_f(shader_uniform_color, blend_color[0], blend_color[1], blend_color[2])
	shader_set_uniform_f(shader_uniform_percent, blend_amt)
	
}