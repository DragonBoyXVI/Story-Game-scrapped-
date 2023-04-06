
var _hp_per = stat_hp / stat_hp_max_real

image_speed = stat_spd / fun_battleunit_speed()

if (_hp_per < 0.25 /*or stat_hp < 4*/) then {
	sprite_index = struct_sprites.idle_low_hp
} else {
	sprite_index = struct_sprites.idle
}