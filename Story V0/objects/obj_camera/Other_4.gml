
view_enabled = true
view_visible[0] = true
camera_set_view_target(VIEW, id)

view_hport[0] = SCREEN_HEIGHT
view_wport[0] = SCREEN_WIDTH

camera_set_view_border(VIEW, 9999, 9999)

camera_set_view_size(VIEW, SCREEN_WIDTH/lens_current, SCREEN_HEIGHT/lens_current)

var _inst_layer = layer_get_id("Instances")

depth = layer_get_depth(_inst_layer)-1