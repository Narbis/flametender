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