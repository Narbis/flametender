if (lit)
{
	part_particles_create(global.particle_system, x - 4, y - 2, global.flame_particle, 3);
	
	lit_counter++;
	if (lit_counter == lit_frames)
	{
		lit = false;
	}
}
if (objPlayer.puzzles[puzzle_num])
{
	lit = true;
}