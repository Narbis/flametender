ui_particle_system = part_system_create();
part_system_automatic_draw(ui_particle_system, false);

previous_flame = objPlayer.flame; // keeps track of when to do ember bursts

// UI flame particle
ui_flame_particle = part_type_create();
part_type_sprite(ui_flame_particle, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle, 2, 6, -0.4, 0);
part_type_orientation(ui_flame_particle, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle, c_orange, c_red);
part_type_alpha3(ui_flame_particle, 1, 1, 0);
part_type_blend(ui_flame_particle, 1);
part_type_direction(ui_flame_particle, 85, 95, 0, 0);
part_type_speed(ui_flame_particle, 0.8, 6, -0.2, 0);
part_type_life(ui_flame_particle, 15, 20);

// UI ember particle
ui_ember_particle = part_type_create();
part_type_shape(ui_ember_particle, pt_shape_pixel);
part_type_scale(ui_ember_particle, 4, 4);
part_type_color1(ui_ember_particle, c_orange);
part_type_alpha3(ui_ember_particle, 1, 0.7, 0);
part_type_blend(ui_ember_particle, 1);
part_type_speed(ui_ember_particle, 0.4, 4, 0, 2);
part_type_direction(ui_ember_particle, 0, 360, 0, 10);
part_type_gravity(ui_ember_particle, 0.1, 90);
part_type_life(ui_ember_particle, 30, 90);