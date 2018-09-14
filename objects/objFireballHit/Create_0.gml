audio_play_sound(sndFireballHit, 0, 0);
part_particles_create(global.particle_system, x, y, global.b_flame_particle, 30);
part_particles_create(global.particle_system, x, y, global.b_ember_particle, 10);
part_particles_create(global.particle_system, x, y, global.shockwave_particle, 1);