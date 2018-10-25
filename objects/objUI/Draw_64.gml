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
				draw_sprite_ext(sprFlameScorch, 0, 64 + (64 * i), 64, 4, 4, 0, c_white, 1);
			}
			else
			{
				part_particles_create(ui_particle_system, 64 + (64 * i), 64, ui_flame_particle, 1);
			}
	
			if (previous_flame > objPlayer.flame)
			{
				part_particles_create(ui_particle_system, 64 + (64 * objPlayer.flame), 64, ui_ember_particle, 10);
			}
			if (objPlayer.flame > previous_flame)
			{
				part_particles_create(ui_particle_system, 64 + (64 * previous_flame), 64, ui_ember_particle, 10);
			}
		}
		
		if (new_flame_animation)
		{
			draw_sprite_ext(sprNewFlame, new_flame_frame / 5, 64 + (64 * (objPlayer.flame_max)), 64, 4, 4, 0, c_white, 1);
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
				draw_sprite_ext(sprLifeEmpty, 0, 1856 - (64 * i), 64, 4, 4, 0, c_white, 1);
			}
			else
			{
				draw_sprite_ext(sprLife, 0, 1856 - (64 * i), 64, 4, 4, 0, c_white, 1);
			}
		}
		
		if (new_life_animation)
		{
			draw_sprite_ext(sprNewLife, new_life_frame / 5, 1856 - (64 * (objPlayer.life_max)), 64, 4, 4, 0, c_white, 1);
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
			draw_rectangle(0, 0, 1920, 1080, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
		else
		{
			state = ui_states.fade_out;
			frame_counter = 0;
			draw_set_color(c_black);
			draw_rectangle(0, 0, 1920, 1080, false);
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
			draw_rectangle(0, 0, 1920, 1080, false);
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