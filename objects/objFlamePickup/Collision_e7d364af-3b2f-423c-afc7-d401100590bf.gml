objPlayer.flame = objPlayer.flame_max;
objPlayer.flamepickups[flame_pickup_num] = true;
part_particles_create(global.particle_system, x, y, global.b_ember_particle, 50);
part_particles_create(global.particle_system, x, y, global.shockwave_particle, 1);
objUI.new_flame_animation = true;
instance_destroy();