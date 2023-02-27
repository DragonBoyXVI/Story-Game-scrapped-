#region game data and macs

global.yscale = 1
#macro YSCALE (global.yscale)

global.game = {}

global.settings = {
	shader_on: true,
}



#endregion game data and macs
#region enums

enum PLAYERS {
	
	DRAC,
	KATE,
	MUD,
	FEVIR,
	JAB,
	
}

enum BEASTS {
	
	DRAC,
	KATE,
	MUD,
	FEVIR,
	JAB,
	
	ALLBEASTS,
	
}

enum STATES {
	
	//player
	PLAY,
	IDLE,
	
	//camera
	FOLLOW_POS,
	FOLLOW_OBJ,
	
}

enum FACES {
	
	RIGHT,
	UP,
	LEFT,
	DOWN,
	
}

#endregion enums
#region map keys

keyboard_set_map(ord("W"), vk_up)
keyboard_set_map(ord("A"), vk_left)
keyboard_set_map(ord("S"), vk_down)
keyboard_set_map(ord("D"), vk_right)

keyboard_set_map(ord("Z"), vk_enter)
keyboard_set_map(ord("X"), vk_backspace)

#endregion map keys