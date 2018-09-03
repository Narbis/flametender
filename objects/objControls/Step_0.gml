// All user input is handled by this object's step function

// Menu navigation and 'debugging' controls

if (keyboard_check_pressed(vk_escape))
{
	game_end();
}
else if (keyboard_check_pressed(vk_backspace))
{
	room_restart();
}
else if ((keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1)) && room == room_first)
{
	room_goto_next();
}

// Character actions
		
		if (gamepad)
		{
			
			// User controller input if connected
			
			input_x = gamepad_axis_value(0, gp_axislh);
			input_y = gamepad_axis_value(0, gp_axislv);
			
			if (gamepad_button_check_pressed(0, gp_face1))
			{
				action = input.jump;
			}
			else if (gamepad_button_check_pressed(0, gp_face2))
			{
				action = input.dash;
			}
			else if (gamepad_button_check_pressed(0, gp_face3))
			{
				action = input.attack;
			}
			else
			{
				action = input.none;
			}
		}
		else
		{
			
			// Otherwise use keyboard input
			
			input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
			input_y = keyboard_check(vk_down) - keyboard_check(vk_up);
			
			if (keyboard_check_pressed(vk_space))
			{
				action = input.jump;
			}
			else if (keyboard_check_pressed(ord("Q")))
			{
				action = input.dash;
			}
			else if (keyboard_check_pressed(ord("W")))
			{
				action = input.attack;
			}
			else
			{
				action = input.none;
			}
		}