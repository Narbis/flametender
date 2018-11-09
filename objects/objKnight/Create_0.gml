enum knight_states
{
	idle,
	alerted,
	pursuit,
	turnaround,
	block,
	attack,
	hurt,
	dead
}

// State and movement variables

state = knight_states.idle;
face_right = image_xscale;
reset_animation = false;
shield_active = false;

h_speed = 0;

// State counters and constants

frame_counter = 0;

life = 5;

aggro_distance = 100;
attack_distance = 20;

// Movement constants

move_speed = 0.7;

// Particle emitter

emitter = part_emitter_create(global.particle_system);
part_emitter_region(global.particle_system, emitter, 0, 0, 0, 0, ps_shape_rectangle, ps_distr_invgaussian);

x_spread = 0; // keeps track of spreading fire
y_spread = 0;

// Ash and ember particle
ash_ember_particle = part_type_create();
part_type_shape(ash_ember_particle, pt_shape_pixel);
part_type_scale(ash_ember_particle, 1, 1);
part_type_color2(ash_ember_particle, c_orange, c_gray);
part_type_alpha3(ash_ember_particle, 1, 0.7, 0);
part_type_blend(ash_ember_particle, 1);
part_type_speed(ash_ember_particle, 0.1, 1, 0, 0.5);
part_type_direction(ash_ember_particle, 80, 100, 0, 10);
part_type_gravity(ash_ember_particle, 0.01, 90);
part_type_life(ash_ember_particle, 30, 90);

// Burst ash particle
ash_particle = part_type_create();
part_type_shape(ash_particle, pt_shape_pixel);
part_type_scale(ash_particle, 1, 1);
part_type_color1(ash_particle, c_gray);
part_type_alpha3(ash_particle, 1, 0.7, 0);
part_type_blend(ash_particle, 1);
part_type_speed(ash_particle, 0.1, 1, 0, 0.5);
part_type_direction(ash_particle, 0, 360, 0, 10);
part_type_gravity(ash_particle, 0.01, 90);
part_type_life(ash_particle, 30, 90);