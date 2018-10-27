// Create UI surface if not yet created or destroyed, then set it so all UI drawing is drawn onto it
if (!surface_exists(ui_surface))
{
	ui_surface = surface_create(480, 270);
}
surface_set_target(ui_surface);
draw_clear_alpha(c_black, 0);

switch(state)
{
	case ui_states.title:
	
		part_emitter_burst(ui_particle_system, title_emitter, title_flame_particle, 15);
		part_emitter_burst(ui_particle_system, embers_emitter, title_ember_particle, 5);
		
		part_system_drawit(ui_particle_system);
	
	break;
	
	case ui_states.menu:
	
	break;
	
	case ui_states.game:
	
		// Hide cursor
		
		window_set_cursor(cr_none);

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
			draw_sprite_ext(sprNewFlame, new_flame_frame / 5, 16 + (16 * (objPlayer.flame_max)), 16, 1, 1, 0, c_white, 1);
			new_flame_frame += 1;
			
			if (new_flame_frame >= 80)
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
			draw_sprite_ext(sprNewLife, new_life_frame / 5, 464 - (16 * (objPlayer.life_max)), 16, 1, 1, 0, c_white, 1);
			new_life_frame += 1;
			
			if (new_life_frame >= 80)
			{
				new_life_animation = false;
				new_life_frame = 0;
				objPlayer.life_max += 1;
				objPlayer.life = objPlayer.life_max;
			}
		}

		part_system_drawit(ui_particle_system);

		previous_flame = objPlayer.flame;
	
	break;
	
	case ui_states.fade_in:
	
		// Hide cursor
		
		window_set_cursor(cr_none);
		
		if (transition_alpha < 1)
		{
			transition_alpha += 0.1;
			draw_set_alpha(transition_alpha);
			draw_set_color(c_black);
			draw_rectangle(0, 0, 480, 270, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
		else
		{
			state = ui_states.fade_out;
			frame_counter = 0;
			draw_set_color(c_black);
			draw_rectangle(0, 0, 480, 270, false);
			draw_set_color(c_white);
		}

	break;
	
	case ui_states.fade_out:

		// Hide cursor
		
		window_set_cursor(cr_none);
		
		if (transition_alpha > 0)
		{
			transition_alpha -= 0.1;
			draw_set_alpha(transition_alpha);
			draw_set_color(c_black);
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

// Draw the UI surface

draw_surface(ui_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));