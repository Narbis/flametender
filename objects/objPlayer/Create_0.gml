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
frame_counter = 0;

// State frame constants

jump_buffer_frames = 5;
walk_transition_frames = 10;
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
global.dust_particle = part_type_create();
part_type_sprite(global.dust_particle, sprRunDust, 1, 1, 0);
part_type_scale(global.dust_particle, 1, 1);
part_type_alpha2(global.dust_particle, 1, 0);
part_type_life(global.dust_particle, 16, 16);