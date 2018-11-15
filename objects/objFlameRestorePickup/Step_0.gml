if (cooldown)
{
	respawn_counter++;
	
	if (respawn_counter == 16)
	{
		image_speed = 0;
	}
	
	if (respawn_counter >= respawn_frames)
	{
		cooldown = false;
		respawning = true;
		respawn_counter = 0;
		scrPlaySound(sndFlameRestorePickupSpawn, x, y);
		sprite_index = sprFlameRestorePickupSpawn;
		image_speed = 1;
	}
}
else
{
	if (respawning)
	{
		respawn_counter++;
		if (respawn_counter >= 16)
		{
			respawning = false;
			respawn_counter = 0;
			sprite_index = sprFlamePickup;
		}
	}
	else
	{
		y = scrWaveMotion(ystart - 2, ystart + 2, 1, 0);
	}
}