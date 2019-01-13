switch (attack)
{
	case attack_types.ground:
	
		if (life_counter == 0)
		{
			x = follow.x + (player_x_sign * 5);
			y = follow.y + 3;
			
			x_motion = 10;
		}
		
		x_motion -= (x_motion / 4);
		
		if (player_x_sign)
		{
			x = (x + x_motion) + (follow.x - player_previous_x);
		}
		else
		{
			x = (x - x_motion) + (follow.x - player_previous_x);
		}
		
		break;
		
	case attack_types.aerial:
	
		if (life_counter == 0)
		{
			x = follow.x + (player_x_sign * 8);
			y = follow.y + 12;
			
			x_motion = 10;
			y_motion = -2;
		}
		
		x_motion -= (x_motion / 4);
		y_motion -= (y_motion / 8);
		
		if (player_x_sign)
		{
			x = (x + x_motion) + (follow.x - player_previous_x);
			y = (y + y_motion) + (follow.y - player_previous_y);
		}
		else
		{
			x = (x - x_motion) + (follow.x - player_previous_x);
			y = (y + y_motion) + (follow.y - player_previous_y);
		}
		
		break;
}

life_counter += 1;
size += 0.1;
part_type_size(attack_particle, size - 0.1, size + 0.1, 0.15, 0);

image_xscale += 0.05;
image_yscale += 0.05;

if (life_counter == duration)
{
	instance_destroy();
}
else
{
	part_particles_create(global.particle_system, x, y, attack_particle, 3);
	//part_particles_create(global.particle_system, x, y, global.ember_particle, 1);
}

player_previous_x = follow.x;
player_previous_y = follow.y;