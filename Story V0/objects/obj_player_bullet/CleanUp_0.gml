
if (audio_emitter_exists(my_emitter)) then audio_emitter_free(my_emitter)
if (audio_is_playing(my_sound)) then audio_stop_sound(my_sound)