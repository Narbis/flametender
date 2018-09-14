if (facing_right == true)
{
	x = x + 6;
}
else
{
	image_xscale = -1;
	x = x - 6;
}
part_particles_create(global.particle_system, x, y, global.ember_particle, 1);
part_particles_create(global.particle_system, x, y, global.s_flame_particle, 3);