
#region wall layer

var _layer = -1

if (layer_exists("Walls")) then _layer = layer_get_id("Walls")
if (layer_exists("walls")) then _layer = layer_get_id("walls")
if (layer_exists("Wall")) then _layer = layer_get_id("Wall")
if (layer_exists("wall")) then _layer = layer_get_id("wall")

wall_layer_elem = _layer == -1 ? -1 : layer_tilemap_get_id(_layer)

#endregion wall layer
#region water layer

_layer = -1

if (layer_exists("Water")) then _layer = layer_get_id("Water")
if (layer_exists("water")) then _layer = layer_get_id("water")

water_layer_elem = _layer == -1 ? -1 : layer_tilemap_get_id(_layer)

#endregion water layer