// All user input is handled by this object's Begin Step Event

// 'Debugging' controls

if (keyboard_check_pressed(vk_escape))
{
	game_end();
}
if (!paused && keyboard_check_pressed(vk_backspace))
{
	objUI.state = ui_states.fade_in;
	objUI.frame_counter = 0;
	objControls.action = input.none;
	
	reset_animation = true;
	frame_counter = 0;
	image_speed = 1;

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
if (has_control)
{
	if (gamepad)
	{
			
		// User controller input if connected
			
		input_x = gamepad_axis_value(0, gp_axislh);
		input_y = gamepad_axis_value(0, gp_axislv);
			
		if (gamepad_button_check_pressed(0, gp_start))
		{
			action = input.start;
			buffer = false;
		}
		else if (instance_exists(objPlayer))
		{
			
			if (gamepad_button_check_released(0, gp_face2))
			{
				action = input.attack;
				buffer = true;
				buffer_counter = 0;
			}
			else if (gamepad_button_check_pressed(0, gp_face2))
			{
				action = input.charge;
				buffer = true;
				buffer_counter = 0;
			}
			else if (gamepad_button_check_pressed(0, gp_face3))
			{
				action = input.activate;
				buffer = false;
			}
			else if (gamepad_button_check_pressed(0, gp_face1))
			{
				action = input.jump;
				buffer = true;
				buffer_counter = 0;
			}
			else if (gamepad_button_check_pressed(0, gp_shoulderrb))
			{
				action = input.dash;
				buffer = true;
				buffer_counter = 0;
			}
			else if (gamepad_button_check_pressed(0, gp_padu))
			{
				debug = !debug;
			}
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
			action = input.start;
			buffer = false;
		}
		else if (instance_exists(objPlayer))
		{
			if (keyboard_check_pressed(ord("E")))
			{
				action = input.activate;
				buffer = false;
			}
			else if (keyboard_check_pressed(vk_space))
			{
				action = input.jump;
				buffer = true;
				buffer_counter = 0;
			}
			else if (keyboard_check_pressed(ord("Q")))
			{
				action = input.dash;
				buffer = true;
				buffer_counter = 0;
			}
			else if (keyboard_check_pressed(ord("W")))
			{
				action = input.attack;
				buffer = true;
				buffer_counter = 0;
			}
			else if (keyboard_check_pressed(vk_tab))
			{
				debug = !debug;
			}
		}
		else
		{
			if (!buffer) 
			{
				action = input.none;
			}
		}
	}
}

if (action == input.start)
{
	if (room == roomTitle)
	{
		room_goto_next();
		audio_play_sound(sndSelect, 10, false);
		action = input.none;
		buffer = false;
		buffer_counter = 0;
		
		objUI.state = ui_states.game;
		objUI.frame_counter = 0;
	
		// Update ember particle
		part_type_speed(global.ember_particle, 0.1, 1, 0, 0.5);
		part_type_gravity(global.ember_particle, 0.01, 90);
		part_type_scale(global.ember_particle, 1, 1);
	}
	else if (objUI.state == ui_states.game || objUI.state == ui_states.menu)
	{
		if (!paused)
		{
			audio_play_sound(sndSelect, 10, false);
			action = input.none;
			buffer = false;
			buffer_counter = 0;
			
			paused = true;
			objUI.state = ui_states.menu;
			
			surface_copy(objUI.ui_surface, (objCamera.x - 240) - camera_get_view_x(view_camera[0]), (objCamera.y - 135) - camera_get_view_y(view_camera[0]), application_surface);
			part_system_automatic_update(global.particle_system, false);
			
			instance_deactivate_all(true);
			instance_activate_object(objUI);
		}
		else
		{
			audio_play_sound(sndSelect, 10, false);
			action = input.none;
			buffer = false;
			buffer_counter = 0;
			
			paused = false;
			objUI.state = ui_states.game;
			
			part_system_automatic_update(global.particle_system, true);
			
			instance_activate_all();
		}
	}
}