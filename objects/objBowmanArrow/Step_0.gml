if (face_right)
{
	if (place_meeting(x + move_speed, y, objWall))
	{
		var h_move = 0;
		while (!place_meeting(x + h_move + 1, y, objWall))
		{
			h_move += 1;
		}
		
		x = x + h_move;
		part_particles_create(global.particle_system, x, y, arrow_deflect_particle, 1);
		audio_play_sound(sndArrowHit, 10, false);
		instance_destroy();
	}
	else
	{
		x = x + move_speed;
	}
}
else
{
	if (place_meeting(x - move_speed, y, objWall))
	{
		var h_move = 0;
		while (!place_meeting(x + h_move - 1, y, objWall))
		{
			h_move -= 1;
		}
		
		x = x + h_move;
		part_type_scale(arrow_deflect_particle, -1, 1);
		part_particles_create(global.particle_system, x, y, arrow_deflect_particle, 1);
		audio_play_sound(sndArrowHit, 10, false);
		instance_destroy();
	}
	else
	{
		x = x - move_speed;
	}
}

