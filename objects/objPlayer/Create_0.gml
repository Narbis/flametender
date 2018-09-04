enum player_states 
{
	idle,
	walk,
	dash,
	run,
	stop,
	turnaround,
	jump,
	fall,
	land,
	climb,
	attack,
	flamedash,
	dead
}

state = player_states.idle;
face_right = true;

h_speed = 0;
v_speed = 0;
v_gravity = 0.25;
move_speed = 3;
jump_speed = 3;
run_threshold = 0.5;
fast_fall_threshold = 0.5;

walk_counter = 0;

if (instance_exists(objControls))
{
	controls = objControls;
}