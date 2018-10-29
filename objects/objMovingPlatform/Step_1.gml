duration_counter += 1;

if (duration_counter >= duration)
{
	h_speed = -h_speed;
	v_speed = -v_speed;
	duration_counter = 0;
}

if (round(objPlayer.y + 16) > y)
{
	mask_index = -1;
}
else
{
	mask_index = sprMovingPlatform;
	if (place_meeting(x, y - 1, objPlayer) && objPlayer.v_speed >= 0)
	{
		objPlayer.x += h_speed;
		objPlayer.y += v_speed;
	}
}

x += h_speed;
y += v_speed;