
if not ai_ctrl then exit

var _ai = is_method(actor.my_ai) ? actor.my_ai : fun_battleunit_default_ai

_ai()