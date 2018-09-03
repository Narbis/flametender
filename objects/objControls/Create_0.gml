// Enum representing input actions

enum input
{
	none,
	jump,
	dash,
	attack
}

action = input.none;

// When the game starts check if a control is connected or not

gamepad = false;

if gamepad_is_connected(0) 
{
	gamepad = true;
	gamepad_set_axis_deadzone(0, 0.2);
}

buffer = false;