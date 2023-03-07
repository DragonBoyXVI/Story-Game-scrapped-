
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
		
	}
	
}