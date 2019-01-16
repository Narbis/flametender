if (life_counter == 0)
{
	x = follow.x + (player_x_sign * 5);
	y = follow.y + 3;
			
	x_motion = 10;
}
		
x_motion -= (x_motion / 20);
		
if (player_x_sign)
{
	x = (x + x_motion) + (follow.x - player_previous_x);
}
else
{
	x = (x - x_motion) + (follow.x - player_previous_x);
}

life_counter += 1;
size += 0.04;
part_type_size(attack_particle, size - 0.01, size + 0.01, 0.05, 0);

image_xscale += 0.02;
image_yscale += 0.02;

if (life_counter > duration)
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