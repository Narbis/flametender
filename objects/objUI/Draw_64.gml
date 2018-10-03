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
	
		draw_set_color(c_white);

		for (i = 0; i < objPlayer.flame_max; i += 1)
		{
			if (i >= objPlayer.flame)
			{
				draw_sprite_ext(sprFlameScorch, 0, 64 + (64 * i), 64, 2, 2, 0, c_white, 1);
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

		part_system_drawit(ui_particle_system);

		previous_flame = objPlayer.flame;
	
	break;
	
	case ui_states.fade_in:
	
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