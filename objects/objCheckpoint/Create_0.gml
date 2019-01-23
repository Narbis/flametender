// Checkpoint flame particle
checkpoint_particle = part_type_create();
part_type_sprite(checkpoint_particle, sprFire, 0, 0, 1);
part_type_size(checkpoint_particle, 0.1, 0.3, -0.005, 0);
part_type_orientation(checkpoint_particle, 0, 360, 5, 0, 0);
part_type_color2(checkpoint_particle, c_white, c_aqua);
part_type_alpha3(checkpoint_particle, 1, 1, 0);
part_type_blend(checkpoint_particle, 1);
part_type_direction(checkpoint_particle, 45, 135, 0, 0);
part_type_speed(checkpoint_particle, 0.5, 1.0, -0.05, 0);
part_type_gravity(checkpoint_particle, 0.05, 90);
part_type_life(checkpoint_particle, 30, 40);

shockwave_particle = part_type_create();
part_type_shape(shockwave_particle, pt_shape_ring);
part_type_scale(shockwave_particle, 0.2, 0.2);
part_type_size(shockwave_particle, 1, 1, 0.5, 0);
part_type_orientation(shockwave_particle, 0, 0, 0, 0, 0);
part_type_color1(shockwave_particle, c_white);
part_type_alpha2(shockwave_particle, 0.1, 0);
part_type_blend(shockwave_particle, 0);
part_type_direction(shockwave_particle, 0, 0, 0, 0);
part_type_speed(shockwave_particle, 0, 0, 0, 0);
part_type_life(shockwave_particle, 14, 14);
part_type_gravity(shockwave_particle, 0, 0);

checkpoint_emitter = part_emitter_create(global.particle_system);
part_emitter_region(global.particle_system, checkpoint_emitter, x - 8, x + 8, y - 4, y + 12, ps_shape_ellipse, ps_distr_linear);
