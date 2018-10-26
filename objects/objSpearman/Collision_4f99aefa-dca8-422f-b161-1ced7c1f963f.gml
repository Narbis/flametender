if (state != spearman_states.dead)
{
	state = spearman_states.dead;
	audio_play_sound(sndBurn, 10, false);
	
	reset_animation = true;
	frame_counter = 0;
}