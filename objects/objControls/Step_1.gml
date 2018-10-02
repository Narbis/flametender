// All user input is handled by this object's Begin Step Event

// 'Debugging' controls

if (keyboard_check_pressed(vk_escape))
{
	game_end();
}
if (keyboard_check_pressed(vk_backspace))
{
	room_restart();
}

// Manage buffered action

if (buffer)
{
	buffer_counter += 1;
	
	if (buffer_counter == buffer_size)
	{
		action = input.none;
		buffer = false;
		buffer_counter = 0;
	}
	
}

// Character actions
		
if (gamepad)
{
			
	// User controller input if connected
			
	input_x = gamepad_axis_value(0, gp_axislh);
	input_y = gamepad_axis_value(0, gp_axislv);
			
	if (gamepad_button_check_pressed(0, gp_start))
	{
		start = true;
	}
	else if (gamepad_button_check_pressed(0, gp_face1))
	{
		action = input.jump;
		buffer = true;
		buffer_counter = 0;
	}
	else if (gamepad_button_check_pressed(0, gp_shoulderrb) && objPlayer.flame > 0)
	{
		action = input.dash;
		buffer = true;
		buffer_counter = 0;
	}
	else if (gamepad_button_check_pressed(0, gp_face2) && objPlayer.flame > 0)
	{
		action = input.attack;
		buffer = true;
		buffer_counter = 0;
	}
	else
	{
		if (!buffer)
		{
			action = input.none;
		}
	}
}
else
{
			
	// Otherwise use keyboard input
			
	input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
	input_y = keyboard_check(vk_down) - keyboard_check(vk_up);
			
	if (keyboard_check_pressed(vk_enter))
	{
		start = true;
	}
	else if (keyboard_check_pressed(vk_space))
	{
		action = input.jump;
		buffer = true;
		buffer_counter = 0;
	}
	else if (keyboard_check_pressed(ord("Q")) && objPlayer.flame > 0)
	{
		action = input.dash;
		buffer = true;
		buffer_counter = 0;
	}
	else if (keyboard_check_pressed(ord("W")) && objPlayer.flame > 0)
	{
		action = input.attack;
		buffer = true;
		buffer_counter = 0;
	}
	else
	{
		if (!buffer) 
		{
			action = input.none;
		}
	}
}

if (start == true && room == room_first)
{
	room_goto_next();
	audio_play_sound(sndSelect, 10, false);
	start = false;
	action = input.none;
	buffer = false;
	buffer_counter = 0;
	
	// Destory menu particle emitters
	part_emitter_destroy_all(global.particle_system);
	
	// Update ember particle
	part_type_speed(global.ember_particle, 0.1, 1, 0, 0.5);
	part_type_gravity(global.ember_particle, 0.01, 90);
	part_type_scale(global.ember_particle, 1, 1);
}