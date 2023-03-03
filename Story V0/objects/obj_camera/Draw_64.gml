draw_text(0, 0, string("Yscale: {0}", YSCALE))

global.yscale += 0.01 * (keyboard_check(ord("0")) - keyboard_check(ord("9")))