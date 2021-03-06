// Collision with a fireball will overwrite whatever state the spearman is currently in

if (state != knight_states.dead && state != knight_states.hurt)
{	
	state = knight_states.hurt;
	
	v_speed = -0.75;
	h_speed = 0.75 * sign(x - other.x);
	life -= 1;
	
	if (life <= 0)
	{
		state = knight_states.dead;
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