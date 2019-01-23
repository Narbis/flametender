enum player_states
{
	idle,
	crouch,
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
	charged_attack,
	aerialattack,
	flamedash,
	hurt,
	dead,
	save
}

enum fall_states
{
	light,
	heavy,
	danger
}

// Arrays to keep track of which Flame pickups have been collected / which puzzles have been finished

flamepickups[0] = false;
flamepickups[1] = false;
flamepickups[2] = false;

puzzles[0] = false;
puzzles[1] = false;
puzzles[2] = false;
puzzles[3] = false;
puzzles[4] = false;
puzzles[5] = false;
puzzles[6] = false;

keys[0] = false;
keys[1] = false;

key = false;
bunny = false;

deaths = 0;
dashes = 0;
attacks = 0;

// this stuff is for room transitions and checkpoints

transition_room = roomStart;
transition_x = 48;
transition_y = 176;

checkpoint_set = false;
checkpoint_room = roomStart;
checkpoint_x = 48;
checkpoint_y = 176;
checkpoint_flame = 30;

// State and movement variables

state = player_states.idle;
fall = fall_states.light;
face_right = true;
reset_animation = false;
finish_animation = false;
ledge = noone;
dash_grounded = true; // this is only used for flamedashes
dash_ready = true;
invuln = false; // used for having a moment to escape after getting hurt
attack_combo = 0; // keeps track of how many hits in a multi-hit attack have been done
max_combo = 1;
charge_counter = 0;
save_animation_counter = 0;

h_speed = 0;
v_speed = 0;
flame = 30;
flame_max = 30;

// State counters

jump_buffer = 0;
walk_transition_counter = 0;
slide_fall_transition_counter = 0;
hang_climb_transition_counter = 0;
hang_slide_transition_counter = 0;
flame_regen_counter = 0;
frame_counter = 0;
invuln_counter = 0;

// State frame constants

jump_buffer_frames = 5;
walk_transition_frames = 10;
slide_fall_transition_frames = 20;
hang_climb_transition_frames = 10;
hang_slide_transition_frames = 10;
flamedash_frames = 12;
attack_frames = 15;
attack_complete_frames = 30;
aerial_attack_frames = 20;
aerial_attack_complete_frames = 44;
charge_frames = 60;
hurt_frames = 20;
dead_frames = 100;
flame_regen_frames = 500;
invuln_frames = 90;
save_frames = 90;

// Movement constants

v_gravity = 0.14;
move_speed = 1.8;
jump_speed = 2.3; // 3.2 for traditional jump, but aerial drift should be lowered
flamedash_speed = 3.2;

run_threshold = 0.5;
fast_fall_threshold = 0.5;
crouch_threshold = 0.5;

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

// New flame particles
new_flame_particle = part_type_create();
part_type_shape(new_flame_particle, pt_shape_pixel);
part_type_color2(new_flame_particle, c_orange, c_red);
part_type_alpha3(new_flame_particle, 1, 1, 0);
part_type_blend(new_flame_particle, 1);
part_type_direction(new_flame_particle, 0, 0, 0, 0);
part_type_speed(new_flame_particle, 0.5, 3, -0.2, 0);
part_type_life(new_flame_particle, 10, 15);

///Particle Test
flame_charge_particle = part_type_create();
part_type_sprite(flame_charge_particle, sprFireSmall, 0, 1, 0);
part_type_speed(flame_charge_particle, 2, 4, 0, 0);
part_type_orientation(flame_charge_particle, 0, 360, 5, 0, 0);
part_type_color2(flame_charge_particle, c_orange, c_red);
part_type_alpha3(flame_charge_particle, 1, 1, 0);
part_type_blend(flame_charge_particle, 1);
part_type_life(flame_charge_particle, 5, 10);
part_type_size(flame_charge_particle, .1, .3, .01, 0);

// Flame particle
charging_flame_particle = part_type_create();
part_type_sprite(charging_flame_particle, sprFireSmall, 0, 0, 1);
part_type_size(charging_flame_particle, 0.3, 1, -0.05, 0);
part_type_orientation(charging_flame_particle, 0, 360, 5, 0, 0);
part_type_color2(charging_flame_particle, c_orange, c_red);
part_type_alpha3(charging_flame_particle, 1, 1, 0);
part_type_blend(charging_flame_particle, 1);
part_type_direction(charging_flame_particle, 85, 95, 0, 0);
part_type_speed(charging_flame_particle, 0.2, 1.5, -0.05, 0);
part_type_life(charging_flame_particle, 15, 20);