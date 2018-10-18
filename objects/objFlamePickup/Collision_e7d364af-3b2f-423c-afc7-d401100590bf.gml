objPlayer.flame_max += 1;
objPlayer.flamepickups[flame_pickup_num] = true;
part_particles_create(global.particle_system, x, y, global.b_ember_particle, 10);
instance_destroy();