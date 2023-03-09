
view_enabled = true
view_visible[0] = true
camera_set_view_target(VIEW, id)

//view_hport[0] = SCREEN_HEIGHT
//view_wport[0] = SCREEN_WIDTH

view_set_wport(0, SCREEN_WIDTH)
view_set_hport(0, SCREEN_HEIGHT)

camera_set_view_border(VIEW, 9999, 9999)

camera_set_view_size(VIEW, SCREEN_WIDTH/lens_current, SCREEN_HEIGHT/lens_current)


var _inst_layer = layer_get_id("Instances")

depth = layer_get_depth(_inst_layer)+1

#region floor layer

floor_layer = -1

if (layer_exists("Tiles_1")) then {
	floor_layer = layer_get_id("Tiles_1")
} else if (layer_exists("tiles_1")) then {
	floor_layer = layer_get_id("tiles_1")
} else if (layer_exists("floor")) then {
	floor_layer = layer_get_id("floor")
} else if (layer_exists("Floor")) then {
	floor_layer = layer_get_id("Floor")
}

floor_layer_asset = floor_layer == -1 ? -1 : layer_tilemap_get_id(floor_layer)

#endregion floor layer

fun_room_to_shader()
fun_room_to_camsize()


/*
if sequence_exists(stored_seq) then {
	
	layer_sequence_x(stored_seq, camera_get_view_x(VIEW))
	layer_sequence_y(stored_seq, camera_get_view_y(VIEW))
	layer_sequence_xscale(stored_seq, 2/lens_current)
	layer_sequence_yscale(stored_seq, 2/lens_current)
	
}