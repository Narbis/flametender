// Enum representing input actions

enum input
{
	none,
	jump,
	dash,
	attack,
	start
}

action = input.none;
start = false;
input_x = 0;
input_y = 0;

// When the game starts check if a control is connected or not

gamepad = false;

if gamepad_is_connected(0) 
{
	gamepad = true;
	gamepad_set_axis_deadzone(0, 0.2);
}

buffer = false;
buffer_size = 5;
buffer_counter = 0;

// Global particle system stuff

global.particle_system = part_system_create_layer("Front", true);

// Ember particle
global.ember_particle = part_type_create();
part_type_shape(global.ember_particle, pt_shape_pixel);
part_type_scale(global.ember_particle, 2, 2);
part_type_color1(global.ember_particle, c_orange);
part_type_alpha3(global.ember_particle, 1, 0.7, 0);
part_type_speed(global.ember_particle, 1, 3, 0, 0.5);
part_type_direction(global.ember_particle, 60, 120, 0, 2);
part_type_gravity(global.ember_particle, 0.03, 90);
part_type_life(global.ember_particle, 30, 90);

// Flame particle
global.flame_particle = part_type_create();
part_type_sprite(global.flame_particle, sprFire, 0, 0, 1);
part_type_size(global.flame_particle, 1, 2.5, -0.05, 0);
part_type_orientation(global.flame_particle, 0, 360, 2, 0, 0);
part_type_color2(global.flame_particle, c_orange, c_red);
part_type_alpha3(global.flame_particle, 1, 1, 0);
part_type_blend(global.flame_particle, 1);
part_type_direction(global.flame_particle, 85, 95, 0, 0);
part_type_speed(global.flame_particle, 1.5, 6, -0.1, 0);
part_type_life(global.flame_particle, 25, 35);

// Play some meme song?

//audio_play_sound(mscWaveball, 10, true);