if (objControls.gamepad)
{
	sprite_index = sprTitleStartGamepad;
}

title_emitter = part_emitter_create(global.particle_system);
part_emitter_region(global.particle_system, title_emitter, x, x + 480, y + 302, y + 302, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(global.particle_system, title_emitter, global.flame_particle, 15);

embers_emitter = part_emitter_create(global.particle_system);
part_emitter_region(global.particle_system, embers_emitter, x, x + 480, y + 302, y + 302, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(global.particle_system, embers_emitter, global.ember_particle, 5);