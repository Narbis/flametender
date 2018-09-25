if(instance_exists(follow))
{
	if (follow.state == player_states.climb)
	{
		towardY = follow.y - 16;
		if (follow.face_right)
		{
			towardX = follow.x + 5;
		}
		else
		{
			towardX = follow.x - 5;
		}			
	}
	else
	{
		towardX = follow.x;
		towardY = follow.y;
	}
}

x += (towardX - x) / 15;

y += (towardY - y) / 15;

camera_set_view_pos(cam, x - view_w_half, y - view_h_half);