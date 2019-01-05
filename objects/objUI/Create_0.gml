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

game_over = false;

//Surface used to draw UI stuff
ui_surface = noone;

// this stuff is for room transitions; super hacky solution, change this later
transition_room = roomStart;
transition_x = 48;
transition_y = 176;

ui_particle_system = part_system_create();
title_emitter = part_emitter_create(ui_particle_system);
part_emitter_region(ui_particle_system, title_emitter, 0, 480, 270, 270, ps_shape_rectangle, ps_distr_linear);
embers_emitter = part_emitter_create(ui_particle_system);
part_emitter_region(ui_particle_system, embers_emitter, 0, 480, 270, 270, ps_shape_rectangle, ps_distr_linear);
part_system_automatic_draw(ui_particle_system, false);

previous_flame = 0; // keeps track of when to do ember bursts
new_flame_animation = false; // set to true to do the particle effect of picking up a new flame
new_flame_frame = 0;

debug_on = false;
debug_message_counter = 0;
debug_message_frames = 120;

// Flame particle
title_flame_particle = part_type_create();
part_type_sprite(title_flame_particle, sprFire, 0, 0, 1);
part_type_scale(title_flame_particle, 1, 1);
part_type_size(title_flame_particle, 1, 2.5, -0.05, 0);
part_type_orientation(title_flame_particle, 0, 360, 2, 0, 0);
part_type_color2(title_flame_particle, c_orange, c_red);
part_type_alpha3(title_flame_particle, 1, 1, 0);
part_type_blend(title_flame_particle, 1);
part_type_direction(title_flame_particle, 85, 95, 0, 0);
part_type_speed(title_flame_particle, 1.5, 6, -0.1, 0);
part_type_life(title_flame_particle, 25, 35);

title_ember_particle = part_type_create();
part_type_shape(title_ember_particle, pt_shape_pixel);
part_type_scale(title_ember_particle, 2, 2);
part_type_color1(title_ember_particle, c_orange);
part_type_alpha3(title_ember_particle, 1, 0.7, 0);
part_type_blend(title_ember_particle, 1);
part_type_speed(title_ember_particle, 1, 4, 0, 0.5);
part_type_direction(title_ember_particle, 80, 100, 0, 10);
part_type_gravity(title_ember_particle, 0.04, 90);
part_type_life(title_ember_particle, 30, 90);

// UI ember particle
ui_ember_particle = part_type_create();
part_type_shape(ui_ember_particle, pt_shape_pixel);
part_type_scale(ui_ember_particle, 1, 1);
part_type_color1(ui_ember_particle, c_orange);
part_type_alpha3(ui_ember_particle, 1, 0.7, 0);
part_type_blend(ui_ember_particle, 1);
part_type_speed(ui_ember_particle, 0.1, 1, 0, 0.125);
part_type_direction(ui_ember_particle, 0, 360, 0, 10);
part_type_gravity(ui_ember_particle, 0.025, 90);
part_type_life(ui_ember_particle, 30, 90);

// UI flame particle size 10
ui_flame_particle_10 = part_type_create();
part_type_sprite(ui_flame_particle_10, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_10, 0.5, 1.5, -0.1, 0);
part_type_orientation(ui_flame_particle_10, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_10, c_orange, c_red);
part_type_alpha3(ui_flame_particle_10, 1, 1, 0);
part_type_blend(ui_flame_particle_10, 1);
part_type_direction(ui_flame_particle_10, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_10, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_10, 15, 20);

// UI flame particle size 9
ui_flame_particle_9 = part_type_create();
part_type_sprite(ui_flame_particle_9, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_9, 0.45, 1.4, -0.09, 0);
part_type_orientation(ui_flame_particle_9, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_9, c_orange, c_red);
part_type_alpha3(ui_flame_particle_9, 1, 1, 0);
part_type_blend(ui_flame_particle_9, 1);
part_type_direction(ui_flame_particle_9, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_9, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_9, 15, 20);

// UI flame particle size 8
ui_flame_particle_8 = part_type_create();
part_type_sprite(ui_flame_particle_8, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_8, 0.4, 1.3, -0.08, 0);
part_type_orientation(ui_flame_particle_8, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_8, c_orange, c_red);
part_type_alpha3(ui_flame_particle_8, 1, 1, 0);
part_type_blend(ui_flame_particle_8, 1);
part_type_direction(ui_flame_particle_8, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_8, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_8, 15, 20);

// UI flame particle size 7
ui_flame_particle_7 = part_type_create();
part_type_sprite(ui_flame_particle_7, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_7, 0.35, 1.2, -0.07, 0);
part_type_orientation(ui_flame_particle_7, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_7, c_orange, c_red);
part_type_alpha3(ui_flame_particle_7, 1, 1, 0);
part_type_blend(ui_flame_particle_7, 1);
part_type_direction(ui_flame_particle_7, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_7, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_7, 15, 20);

// UI flame particle size 6
ui_flame_particle_6 = part_type_create();
part_type_sprite(ui_flame_particle_6, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_6, 0.3, 1.1, -0.06, 0);
part_type_orientation(ui_flame_particle_6, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_6, c_orange, c_red);
part_type_alpha3(ui_flame_particle_6, 1, 1, 0);
part_type_blend(ui_flame_particle_6, 1);
part_type_direction(ui_flame_particle_6, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_6, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_6, 15, 20);

// UI flame particle size 5
ui_flame_particle_5 = part_type_create();
part_type_sprite(ui_flame_particle_5, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_5, 0.25, 1, -0.05, 0);
part_type_orientation(ui_flame_particle_5, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_5, c_orange, c_red);
part_type_alpha3(ui_flame_particle_5, 1, 1, 0);
part_type_blend(ui_flame_particle_5, 1);
part_type_direction(ui_flame_particle_5, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_5, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_5, 15, 20);

// UI flame particle size 4
ui_flame_particle_4 = part_type_create();
part_type_sprite(ui_flame_particle_4, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_4, 0.2, 0.9, -0.04, 0);
part_type_orientation(ui_flame_particle_4, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_4, c_orange, c_red);
part_type_alpha3(ui_flame_particle_4, 1, 1, 0);
part_type_blend(ui_flame_particle_4, 1);
part_type_direction(ui_flame_particle_4, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_4, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_4, 15, 20);

// UI flame particle size 3
ui_flame_particle_3 = part_type_create();
part_type_sprite(ui_flame_particle_3, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_3, 0.15, 0.8, -0.03, 0);
part_type_orientation(ui_flame_particle_3, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_3, c_orange, c_red);
part_type_alpha3(ui_flame_particle_3, 1, 1, 0);
part_type_blend(ui_flame_particle_3, 1);
part_type_direction(ui_flame_particle_3, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_3, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_3, 15, 20);

// UI flame particle size 2
ui_flame_particle_2 = part_type_create();
part_type_sprite(ui_flame_particle_2, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_2, 0.1, 0.7, -0.02, 0);
part_type_orientation(ui_flame_particle_2, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_2, c_orange, c_red);
part_type_alpha3(ui_flame_particle_2, 1, 1, 0);
part_type_blend(ui_flame_particle_2, 1);
part_type_direction(ui_flame_particle_2, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_2, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_2, 15, 20);

// UI flame particle size 1
ui_flame_particle_1 = part_type_create();
part_type_sprite(ui_flame_particle_1, sprFireSmall, 0, 0, 1);
part_type_size(ui_flame_particle_1, 0.05, 0.6, -0.01, 0);
part_type_orientation(ui_flame_particle_1, 0, 360, 5, 0, 0);
part_type_color2(ui_flame_particle_1, c_orange, c_red);
part_type_alpha3(ui_flame_particle_1, 1, 1, 0);
part_type_blend(ui_flame_particle_1, 1);
part_type_direction(ui_flame_particle_1, 85, 95, 0, 0);
part_type_speed(ui_flame_particle_1, 0.2, 1.5, -0.05, 0);
part_type_life(ui_flame_particle_1, 15, 20);