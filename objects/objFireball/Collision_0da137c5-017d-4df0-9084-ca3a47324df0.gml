if(facing_right)
{
	scrPlaySound(sndFireballHit, x, y);
	part_particles_create(global.particle_system, x + 4, y, global.b_flame_particle, 30);
	part_particles_create(global.particle_system, x + 4, y, global.b_ember_particle, 10);
	part_particles_create(global.particle_system, x + 4, y, global.shockwave_particle, 1);
}
else
{
	scrPlaySound(sndFireballHit, x, y);
	part_particles_create(global.particle_system, x - 4, y, global.b_flame_particle, 30);
	part_particles_create(global.particle_system, x - 4, y, global.b_ember_particle, 10);
	part_particles_create(global.particle_system, x - 4, y, global.shockwave_particle, 1);
}

instance_destroy();