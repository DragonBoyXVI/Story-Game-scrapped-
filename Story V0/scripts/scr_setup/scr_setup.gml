#region game data and macs

global.game = {}

global.settings = {}



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

#endregion enums
#region map keys

keyboard_set_map(ord("W"), vk_up)
keyboard_set_map(ord("A"), vk_left)
keyboard_set_map(ord("S"), vk_down)
keyboard_set_map(ord("D"), vk_right)

keyboard_set_map(ord("Z"), vk_enter)
keyboard_set_map(ord("X"), vk_backspace)

#endregion map keys