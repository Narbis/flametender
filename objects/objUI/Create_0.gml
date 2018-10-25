enum ui_states
{
	title,
	menu,
	game,
	fade_in,
	fade_out
}

state = ui_states.title;
frame_counter = 0;
transition_alpha = 0;

// this stuff is for room transitions; super hacky solution, change this later
transition_room = roomStart;
transition_x = 48;
transition_y = 176;

ui_particle_system = part_system_create();
title_emitter = part_emitter_create(ui_particle_system);
part_emitter_region(ui_particle_system, title_emitter, 0, 1920, 1080, 1080, ps_shape_rectangle, ps_distr_linear);
embers_emitter = part_emitter_create(ui_particle_system);
part_emitter_region(ui_particle_system, embers_emitter, 0, 1920, 1080, 1080, ps_shape_rectangle, ps_distr_linear);
part_system_automatic_draw(ui_particle_system, false);

previous_flame = 0; // keeps track of when to do ember bursts
new_flame_animation = false; // set to true to do the particle effect of picking up a new flame
new_flame_frame = 0;

new_life_animation = false;
new_life_frame = 0;

// Flame particle
title_flame_particle = part_type_create();
part_type_sprite(title_flame_particle, sprFire, 0, 0, 1);
part_type_scale(title_flame_particle, 4, 4);
part_type_size(title_flame_particle, 1, 2.5, -0.05, 0);
part_type_orientation(title_flame_particle, 0, 360, 2, 0, 0);
part_type_color2(title_flame_particle, c_orange, c_red);
part_type_alpha3(title_flame_particle, 1, 1, 0);
part_type_blend(title_flame_particle, 1);
part_type_direction(title_flame_particle, 85, 95, 0, 0);
part_type_speed(title_flame_particle, 6, 24, -0.4, 0);
part_type_life(title_flame_particle, 25, 35);

title_ember_particle = part_type_create();
part_type_shape(title_ember_particle, pt_shape_pixel);
part_type_scale(title_ember_particle, 8, 8);
part_type_color1(title_ember_particle, c_orange);
part_type_alpha3(title_ember_particle, 1, 0.7, 0);
part_type_blend(title_ember_particle, 1);
part_type_speed(title_ember_particle, 4, 12, 0, 2);
part_type_direction(title_ember_particle, 80, 100, 0, 10);
part_type_gravity(title_ember_particle, 0.12, 90);
part_type_life(title_ember_particle, 30, 90);

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