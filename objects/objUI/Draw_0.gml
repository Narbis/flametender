// Create UI surface if not yet created or destroyed, then set it so all UI drawing is drawn onto it
if (!surface_exists(ui_surface))
{
	ui_surface = surface_create(480, 270);
}
surface_set_target(ui_surface);
if (state != ui_states.menu)
{
	draw_clear_alpha(c_black, 0);
}

switch(state)
{
	case ui_states.title:
	
		part_emitter_burst(ui_particle_system, title_emitter, title_flame_particle, 15);
		part_emitter_burst(ui_particle_system, embers_emitter, title_ember_particle, 5);
		
		part_system_drawit(ui_particle_system);
	
	break;
	
	case ui_states.menu:
	
		draw_sprite_ext(sprPauseMenui, 0, 240, 135, 1, 1, 0, c_white, 1);
	
	break;
	
	case ui_states.game:
	
		// Hide cursor
		
		window_set_cursor(cr_none);


		if (!game_over)
		{
		
			// UI Flame

			for (i = 0; i < objPlayer.flame_max; i += 1)
			{
				if (i >= objPlayer.flame)
				{
					draw_sprite_ext(sprFlameScorch, 0, 16 + (16 * i), 16, 1, 1, 0, c_white, 1);
				}
				else
				{
					part_particles_create(ui_particle_system, 16 + (16 * i), 16, ui_flame_particle, 1);
				}
	
				if (previous_flame > objPlayer.flame)
				{
					part_particles_create(ui_particle_system, 16 + (16 * objPlayer.flame), 16, ui_ember_particle, 10);
				}
				if (objPlayer.flame > previous_flame)
				{
					part_particles_create(ui_particle_system, 16 + (16 * previous_flame), 16, ui_ember_particle, 10);
				}
			}
		
			if (new_flame_animation)
			{
				draw_sprite_ext(sprNewFlame, new_flame_frame / 3, 16 + (16 * (objPlayer.flame_max)), 16, 1, 1, 0, c_white, 1);
				new_flame_frame += 1;
			
				if (new_flame_frame >= 48)
				{
					new_flame_animation = false;
					new_flame_frame = 0;
					objPlayer.flame_max += 1;
					objPlayer.flame = objPlayer.flame_max;
				}
			}
		
			// UI Life

			for (i = 0; i < objPlayer.life_max; i += 1)
			{
				if (i >= objPlayer.life)
				{
					draw_sprite_ext(sprLifeEmpty, 0, 464 - (16 * i), 16, 1, 1, 0, c_white, 1);
				}
				else
				{
					draw_sprite_ext(sprLife, 0, 464 - (16 * i), 16, 1, 1, 0, c_white, 1);
				}
			}
		
			if (new_life_animation)
			{
				draw_sprite_ext(sprNewLife, new_life_frame / 2, 464 - (16 * (objPlayer.life_max)), 16, 1, 1, 0, c_white, 1);
				new_life_frame += 1;
			
				if (new_life_frame >= 32)
				{
					new_life_animation = false;
					new_life_frame = 0;
					objPlayer.life_max += 1;
					objPlayer.life = objPlayer.life_max;
				}
			}
		
			if (debug_message_counter != 0 || debug_on != objControls.debug)
			{
				if (debug_on != objControls.debug)
				{
					debug_message_counter = 0;
					debug_on = !debug_on;
				}
			
				debug_message_counter++;
			
				if (debug_message_counter >= debug_message_frames)
				{
					debug_message_counter = 0;
				}
			
				if (debug_on)
				{
					if (objControls.gamepad)
					{
						draw_sprite_ext(sprDebugMessage, 0, 0, 16, 1, 1, 0, c_white, 1);
					}
					else
					{
						draw_sprite_ext(sprDebugMessage, 1, 0, 16, 1, 1, 0, c_white, 1);
					}
				}
				else
				{
					if (objControls.gamepad)
					{
						draw_sprite_ext(sprDebugMessage, 2, 0, 16, 1, 1, 0, c_white, 1);
					}
					else
					{
						draw_sprite_ext(sprDebugMessage, 3, 0, 16, 1, 1, 0, c_white, 1);
					}
				}
			}

			part_system_drawit(ui_particle_system);

			previous_flame = objPlayer.flame;
		}
		else
		{
			
			// Display results screen
			
			// Flame
			for (i = 0; i < 3; i += 1)
			{
				if (i >= objPlayer.flame_max)
				{
					draw_sprite_ext(sprFlameScorch, 0, 158 + (16 * i), 84, 1, 1, 0, c_white, 1);
				}
				else
				{
					part_particles_create(ui_particle_system, 158 + (16 * i), 84, ui_flame_particle, 1);
				}
			}
			
			// Hearts
			for (i = 3; i < 6; i += 1)
			{
				if (i >= objPlayer.life_max)
				{
					draw_sprite_ext(sprLifeEmpty, 0, 200 + (16 * (i - 3)), 120, 1, 1, 0, c_white, 1);
				}
				else
				{
					draw_sprite_ext(sprLife, 0, 200 + (16 * (i - 3)), 120, 1, 1, 0, c_white, 1);
				}
			}
			
			// Bunny
			if (objPlayer.bunny)
			{
				draw_sprite_ext(sprWeirdSmiles, 0, 180, 156, 1, 1, 0, c_white, 1);
			}
			else
			{
				draw_sprite_ext(sprWeirdSilouette, 0, 180, 156, 1, 1, 0, c_white, 1);
			}
			
			// Numbers
			draw_set_font(fntGeorgia);
			draw_text_color(404, 75, objPlayer.dashes, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
			draw_text(403, 74, objPlayer.dashes);
			draw_text_color(409, 114, objPlayer.attacks, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
			draw_text(408, 113, objPlayer.attacks);
			draw_text_color(362, 150, objPlayer.deaths, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
			draw_text(361, 149, objPlayer.deaths);
			
			part_system_drawit(ui_particle_system);
			
		}
	
	break;
	
	case ui_states.fade_in:
	
		// Hide cursor
		
		window_set_cursor(cr_none);
		
		if (transition_alpha < 1)
		{
			if (game_over)
			{
				draw_set_color(c_white);
				transition_alpha += 0.01;
			}
			else
			{
				draw_set_color(c_black);
				transition_alpha += 0.1;
			}
			draw_set_alpha(transition_alpha);
			draw_rectangle(0, 0, 480, 270, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
		else
		{
			state = ui_states.fade_out;
			frame_counter = 0;
			if (game_over)
			{
				draw_set_color(c_white);
			}
			else
			{
				draw_set_color(c_black);
			}
			draw_rectangle(0, 0, 480, 270, false);
			draw_set_color(c_white);
		}

	break;
	
	case ui_states.fade_out:

		// Hide cursor
		
		window_set_cursor(cr_none);
		
		if (transition_alpha > 0)
		{
			if (game_over)
			{
				draw_set_color(c_white);
				transition_alpha -= 0.03;
			}
			else
			{
				draw_set_color(c_black);
				transition_alpha -= 0.1;
			}
			draw_set_alpha(transition_alpha);
			draw_rectangle(0, 0, 480, 270, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
		else
		{
			state = ui_states.game;
			frame_counter = 0;
		}
	
	break;
}

// Reset surface when finished
surface_reset_target();

draw_surface(ui_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));