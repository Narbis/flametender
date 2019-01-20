// Collision with a fireball will overwrite whatever state the bat is currently in

if (state != bat_states.dead && state != bat_states.hurt)
{	
	state = bat_states.hurt;
	
	instance_destroy(hitbox);
	hitbox = noone;
	
	v_speed = -1;
	h_speed = sign(x - other.x);
	life -= 1;
	
	if (life <= 0)
	{
		state = bat_states.dead;
		scrPlaySound(sndBurn, x, y);
	}
	else
	{
		//scrPlaySound(sndSpearmanHurt, x, y);
	}
	
	reset_animation = true;
	frame_counter = 0;
	image_speed = 1;
}