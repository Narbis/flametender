if (facing_right == true)
{
	x = x + 6;
}
else
{
	image_xscale = -1;
	x = x - 6;
}

life_counter += 1;
size += 0.1;
part_type_size(attack_particle, size - 0.1, size + 0.1, 0.15, 0);

if (life_counter < 11)
{
	part_particles_create(global.particle_system, x, y, attack_particle, 3);
	part_particles_create(global.particle_system, x, y, global.ember_particle, 1);
}

if (life_counter > 11)
{
	instance_destroy();
}