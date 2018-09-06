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
	climb,
	attack,
	flamedash,
	dead
}

enum fall_states
{
	light,
	heavy,
	hurt
}

// State and movement variables

state = player_states.idle;
fall = fall_states.light;
face_right = true;
reset_animation = false;

h_speed = 0;
v_speed = 0;

// State counters

jump_buffer = 0;
walk_transition_counter = 0;
flamedash_counter = 0;
attack_counter = 0;

// State frame constants

jump_buffer_frames = 5;
walk_transition_frames = 3;
flamedash_frames = 10;
attack_frames = 20;

// Movement constants

v_gravity = 0.25;
move_speed = 1.8;
jump_speed = 3;
flamedash_speed = 5;

run_threshold = 0.5;
fast_fall_threshold = 0.5;

if (instance_exists(objControls))
{
	controls = objControls;
}