// Enum representing input actions

enum input
{
	none,
	jump,
	dash,
	attack
}

action = input.none;
input_x = 0;
input_y = 0;

// When the game starts check if a control is connected or not

gamepad = false;

if gamepad_is_connected(0) 
{
	gamepad = true;
	gamepad_set_axis_deadzone(0, 0.2);
}

buffer = false;
buffer_size = 5;
buffer_counter = 0;

// Play some meme song

audio_play_sound(mscWaveball, 10, true);