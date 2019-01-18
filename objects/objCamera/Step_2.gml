if (initialized)
{
	if (follow.state == player_states.save && follow.save_animation_counter == 0)
	{
		view_h_half *= .99;
		view_w_half *= .99;
	}
	else
	{
		view_h_half = min(view_h_half * 1.1, 135);
		view_w_half = min(view_w_half * 1.1, 240);
	}
	
	camera_set_view_size(cam, view_w_half * 2, view_h_half * 2);
		
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
		
		// Camera moves slower when climbing so the camera doesn't snap too much
		
		x += (towardX - x) / 20;
		y += (towardY - y) / 20;
	}
	else
	{
		towardX = follow.x;
		towardY = follow.y;
		
		// Camera moves to keep up with the player; it gets faster the farther away it is

		x += (towardX - x) / 12;
		y += (towardY - y) / 12;
	}

	// Limit the bounds of the camera to the room's width and height

	if (x < view_w_half)
	{
		x = view_w_half;
	}
	if (x > room_width - view_w_half)
	{
		x = room_width - view_w_half;
	}
	if (y < view_h_half)
	{
		y = view_h_half;
	}
	if (y > room_height - view_h_half)
	{
		y = room_height - view_h_half;
	}

	camera_set_view_pos(cam, x - view_w_half, y - view_h_half);
	
	if (layer_exists("Parallax_F"))
	{
		layer_x("Parallax_F", x * 0.3);
	}
	if (layer_exists("Parallax_B"))
	{
		layer_x("Parallax_B", x * 0.6);
	}
}
else
{
	if (instance_exists(objPlayer))
	{
		follow = objPlayer;
		initialized = true;
	}
}

if (keyboard_check_pressed(vk_space))
{
	camera_set_view_size(cam, view_w_half, view_h_half);
}
if (keyboard_check_released(vk_space))
{
	camera_set_view_size(cam, view_w_half * 2, view_h_half * 2);
}