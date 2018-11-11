objPlayer.life = objPlayer.life_max;
objPlayer.lifepickups[life_pickup_num] = true;
part_particles_create(global.particle_system, x, y, global.shockwave_particle, 1);
objUI.new_life_animation = true;
scrPlaySound(sndHeartPickup, x, y);
instance_destroy();