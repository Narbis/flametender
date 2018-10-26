// Collision with an enemy hitbox will overwrite whatever state the player is currently in

if (state != player_states.dead && !invuln)
{
	
	if (state == player_states.hang)
	{
		if (face_right)
		{
			x = x - 5;
			y = y + 3;
		}
		else
		{
			x = x + 5;
			y = y + 3;
		}
	}
	else if (state == player_states.climb)
	{
		if (face_right)
		{
			x = x - 5;
		}
		else
		{
			x = x + 5;
		}
	}
	
	state = player_states.hurt;
	invuln = true;
	
	v_speed = -2;
	h_speed = 2 * sign(x - other.x);
	if (!controls.debug)
	{
		life -= 1;
	}
	
	reset_animation = true;
	frame_counter = 0;
	image_speed = 1;
}