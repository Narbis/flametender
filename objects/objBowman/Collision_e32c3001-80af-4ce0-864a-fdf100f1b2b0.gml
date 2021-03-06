// Collision with a fireball will overwrite whatever state the spearman is currently in

if (state != bowman_states.dead && state != bowman_states.hurt)
{	
	state = bowman_states.hurt;
	
	v_speed = -1.5;
	h_speed = 1.5 * sign(x - other.x);
	life -= 1;
	
	if (life <= 0)
	{
		state = bowman_states.dead;
		scrPlaySound(sndBurn, x, y);
	}
	else
	{
		scrPlaySound(sndSpearmanHurt, x, y);
	}
	
	reset_animation = true;
	frame_counter = 0;
	image_speed = 1;
}