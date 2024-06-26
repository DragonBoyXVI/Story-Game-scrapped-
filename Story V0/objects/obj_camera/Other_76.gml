
var _type = event_data[? "event_type"]
var _message = event_data[? "message"]
var _elem_id = event_data[? "element_id"]


if (_type == "sequence event") then {
	
	
	
} else { //sprite
	
	var _this = layer_instance_get_instance(_elem_id)
	
	if (_this == noone) then exit
	
	switch(_message) {
		
		case "step claw":
		fun_footstep_clawed(_this.x, _this.y, floor_layer_asset)
		break
		
		case "drac over fire needle":
		with instance_create_depth(_this.x, _this.y-96, _this.depth, obj_player_bullet) {
			
			my_sound = audio_play_sound_on(my_emitter, snd_flying_poison_loop_test, true, 1)
			spd = 100
			
			on_step = function() {
				part_particles_create(global.part_sys, x, y, global.poison_type, 1)
			}
			on_hit = function() {
				part_particles_create(global.part_sys, x, y, global.poison_type, 10)
			}
			
			sprite_index = spr_bullet_needle
			image_xscale = 1.5
			image_yscale = 0.5
			
			elem = ELEMENT.POISON
			
			direction = point_direction(x, y, mouse_x, mouse_y)
			
		}
		break
		
		case "drac over make dunder":
		obj_camera.follow_obj = instance_create_depth(_this.x, _this.y, _this.depth, obj_dunder_overworld, {my_owner: _this.id})
		break
		
		case "drac over pop dunder":
		with obj_dunder_overworld {
			state = 2
			event_perform(ev_step, ev_step_normal)
		}
		obj_camera.follow_obj = _this.id
		break
		
		case "over dunder do it":
		with _this {
			fun_check_for_interact(id, instance_place(x, y, obj_cutscene_trigger))
			//state = 4
		}
		break
		
	}
	
}