
if (global.in_trans) then {
	
	if surface_exists(trans_surf) then
		draw_surface(trans_surf, 0, 0)
	
} else if surface_exists(trans_surf) then {
	
	surface_free(trans_surf)
	
}