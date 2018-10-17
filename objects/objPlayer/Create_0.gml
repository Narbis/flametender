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
dash_grounded = true; // this is only used for flamedashes

h_speed = 0;
v_speed = 0;
life = 3;
flame = 0;
flame_max = 0;

// State counters

jump_buffer = 0;
walk_transition_counter = 0;
slide_fall_transition_counter = 0;
hang_climb_transition_counter = 0;
hang_slide_transition_counter = 0;
flame_regen_counter = 0;
frame_counter = 0;

// State frame constants

jump_buffer_frames = 5;
walk_transition_frames = 10;
slide_fall_transition_frames = 20;
hang_climb_transition_frames = 10;
hang_slide_transition_frames = 10;
flamedash_frames = 10;
attack_frames = 20;
hurt_frames = 20;
dead_frames = 120;
flame_regen_frames = 120;

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

global.trail_right_dust_particle = part_type_create();
part_type_sprite(global.trail_right_dust_particle, sprTrailDust, 1, 1, 0);
part_type_scale(global.trail_right_dust_particle, 1, 1);
part_type_alpha2(global.trail_right_dust_particle, 1, 0);
part_type_life(global.trail_right_dust_particle, 24, 24);

global.trail_left_dust_particle = part_type_create();
part_type_sprite(global.trail_left_dust_particle, sprTrailDust, 1, 1, 0);
part_type_scale(global.trail_left_dust_particle, -1, 1);
part_type_alpha2(global.trail_left_dust_particle, 1, 0);
part_type_life(global.trail_left_dust_particle, 24, 24);

global.flamedash_dust_particle = part_type_create();
part_type_sprite(global.flamedash_dust_particle, sprFlameDashDust, 1, 1, 0);
part_type_scale(global.flamedash_dust_particle, 1, 1);
part_type_alpha2(global.flamedash_dust_particle, 1, 0);
part_type_life(global.flamedash_dust_particle, 24, 24);

global.land_slide_dust_particle = part_type_create();
part_type_sprite(global.land_slide_dust_particle, sprLandSlideDust, 1, 1, 0);
part_type_scale(global.land_slide_dust_particle, 1, 1);
part_type_alpha2(global.land_slide_dust_particle, 1, 0);
part_type_life(global.land_slide_dust_particle, 20, 20);

// TEST

// Fire attack particle
attack_particle = part_type_create();
part_type_sprite(attack_particle, sprFireSmall, 0, 0, 1);
part_type_size(attack_particle, 0.1, 0.3, 0.15, 0);
part_type_orientation(attack_particle, 0, 360, 5, 0, 0);
part_type_color2(attack_particle, c_orange, c_red);
part_type_alpha3(attack_particle, 1, 1, 0);
part_type_blend(attack_particle, 1);
part_type_direction(attack_particle, 0, 0, 0, 0);
part_type_speed(attack_particle, 0.5, 3, -0.2, 0);
part_type_life(attack_particle, 10, 15);
part_type_gravity(attack_particle, 0.1, 90);