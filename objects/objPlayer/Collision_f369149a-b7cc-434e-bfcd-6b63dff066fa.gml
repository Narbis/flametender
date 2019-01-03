// Collision with an enemy hitbox will overwrite whatever state the player is currently in

if ((state != player_states.dead && state != player_states.flamedash) && !invuln)
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
	
	v_speed = -1;
	h_speed = sign(x - other.x);
	if (!controls.debug)
	{
		life -= 1;
	}
	
	scrPlaySound(sndPlayerHurt, x, y);
	
	reset_animation = true;
	frame_counter = 0;
	image_speed = 1;
}