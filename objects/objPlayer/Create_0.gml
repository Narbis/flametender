enum player_states 
{
	idle,
	walk,
	dash,
	run,
	stop,
	jump,
	fall,
	lightland,
	heavyland,
	hang,
	climb,
	slide,
	attack,
	flamedash,
	hurt,
	dead
}

enum fall_states
{
	light,
	heavy,
	danger
}

// State and movement variables

state = player_states.idle;
fall = fall_states.light;
face_right = true;
reset_animation = false;
finish_animation = false;
ledge = noone;

h_speed = 0;
v_speed = 0;
life = 3;

// State counters

jump_buffer = 0;
walk_transition_counter = 0;
slide_fall_transition_counter = 0;
frame_counter = 0;

// State frame constants

jump_buffer_frames = 5;
walk_transition_frames = 10;
slide_fall_transition_frames = 10;
flamedash_frames = 10;
attack_frames = 20;
hurt_frames = 20;
dead_frames = 120;

// Movement constants

v_gravity = 0.22;
move_speed = 1.8;
jump_speed = 3;
flamedash_speed = 5;

run_threshold = 0.5;
fast_fall_threshold = 0.5;

if (instance_exists(objControls))
{
	controls = objControls;
}

// Particle system

flamedash_emitter = part_emitter_create(global.particle_system);

// Dust particles

global.run_right_dust_particle = part_type_create();
part_type_sprite(global.run_right_dust_particle, sprRunDust, 1, 1, 0);
part_type_scale(global.run_right_dust_particle, 1, 1);
part_type_alpha2(global.run_right_dust_particle, 1, 0);
part_type_life(global.run_right_dust_particle, 16, 16);

global.run_left_dust_particle = part_type_create();
part_type_sprite(global.run_left_dust_particle, sprRunDust, 1, 1, 0);
part_type_scale(global.run_left_dust_particle, -1, 1);
part_type_alpha2(global.run_left_dust_particle, 1, 0);
part_type_life(global.run_left_dust_particle, 16, 16);

global.stop_right_dust_particle = part_type_create();
part_type_sprite(global.stop_right_dust_particle, sprStopDust, 1, 1, 0);
part_type_scale(global.stop_right_dust_particle, 1, 1);
part_type_alpha2(global.stop_right_dust_particle, 1, 0);
part_type_life(global.stop_right_dust_particle, 16, 16);

global.stop_left_dust_particle = part_type_create();
part_type_sprite(global.stop_left_dust_particle, sprStopDust, 1, 1, 0);
part_type_scale(global.stop_left_dust_particle, -1, 1);
part_type_alpha2(global.stop_left_dust_particle, 1, 0);
part_type_life(global.stop_left_dust_particle, 16, 16);

global.lightland_dust_particle = part_type_create();
part_type_sprite(global.lightland_dust_particle, sprLightLandDust, 1, 1, 0);
part_type_scale(global.lightland_dust_particle, 1, 1);
part_type_alpha2(global.lightland_dust_particle, 1, 0);
part_type_life(global.lightland_dust_particle, 12, 12);

global.heavyland_dust_particle = part_type_create();
part_type_sprite(global.heavyland_dust_particle, sprHeavyLandDust, 1, 1, 0);
part_type_scale(global.heavyland_dust_particle, 1, 1);
part_type_alpha2(global.heavyland_dust_particle, 1, 0);
part_type_life(global.heavyland_dust_particle, 24, 24);

global.slide_right_dust_particle = part_type_create();
part_type_sprite(global.slide_right_dust_particle, sprSlideDust, 1, 1, 0);
part_type_scale(global.slide_right_dust_particle, 1, 1);
part_type_alpha2(global.slide_right_dust_particle, 1, 0);
part_type_life(global.slide_right_dust_particle, 40, 40);

global.slide_left_dust_particle = part_type_create();
part_type_sprite(global.slide_left_dust_particle, sprSlideDust, 1, 1, 0);
part_type_scale(global.slide_left_dust_particle, -1, 1);
part_type_alpha2(global.slide_left_dust_particle, 1, 0);
part_type_life(global.slide_left_dust_particle, 40, 40);