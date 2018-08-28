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
move_speed = 1.8;
jump_speed = 3;

gamepad = false;

if gamepad_is_connected(0) 
{
	gamepad = true;
	gamepad_set_axis_deadzone(0, 0.2);
}