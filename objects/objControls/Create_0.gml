// Enum representing input actions

enum input
{
	none,
	jump,
	dash,
	attack,
	charge,
	start,
	activate
}

surface_resize(application_surface, 480, 270);
display_set_gui_size(480, 270);

has_control = true;
action = input.none;
debug = false;
paused = false;
input_x = 0;
input_y = 0;

// When the game starts check if a control is connected or not

gamepad = false;

if gamepad_is_connected(0) 
{
	gamepad = true;
	gamepad_set_axis_deadzone(0, 0.35);
}

buffer = false;
buffer_size = 10;
buffer_counter = 0;

// Global particle system stuff

global.particle_system = part_system_create_layer("Front", true);

// Ember particle
global.ember_particle = part_type_create();
part_type_shape(global.ember_particle, pt_shape_pixel);
part_type_scale(global.ember_particle, 1, 1);
part_type_color1(global.ember_particle, c_orange);
part_type_alpha3(global.ember_particle, 1, 0.7, 0);
part_type_blend(global.ember_particle, 1);
part_type_speed(global.ember_particle, 0.1, 1, 0, 0.5);
part_type_direction(global.ember_particle, 80, 100, 0, 10);
part_type_gravity(global.ember_particle, 0.01, 90);
part_type_life(global.ember_particle, 30, 90);

// Burst ember particle
global.b_ember_particle = part_type_create();
part_type_shape(global.b_ember_particle, pt_shape_pixel);
part_type_scale(global.b_ember_particle, 1, 1);
part_type_color1(global.b_ember_particle, c_orange);
part_type_alpha3(global.b_ember_particle, 1, 0.7, 0);
part_type_blend(global.b_ember_particle, 1);
part_type_speed(global.b_ember_particle, 0.1, 1, 0, 0.5);
part_type_direction(global.b_ember_particle, 0, 360, 0, 10);
part_type_gravity(global.b_ember_particle, 0.01, 90);
part_type_life(global.b_ember_particle, 30, 90);

// Burst flame particle
global.b_flame_particle = part_type_create();
part_type_sprite(global.b_flame_particle, sprFireSmall, 0, 0, 1);
part_type_size(global.b_flame_particle, 0.5, 1.5, -0.1, 0);
part_type_orientation(global.b_flame_particle, 0, 360, 5, 0, 0);
part_type_color2(global.b_flame_particle, c_orange, c_red);
part_type_alpha3(global.b_flame_particle, 1, 1, 0);
part_type_blend(global.b_flame_particle, 1);
part_type_direction(global.b_flame_particle, 0, 360, 0, 0);
part_type_speed(global.b_flame_particle, 0.2, 1.5, -0.05, 0);
part_type_life(global.b_flame_particle, 15, 20);

// Flame particle
global.flame_particle = part_type_create();
part_type_sprite(global.flame_particle, sprFireSmall, 0, 0, 1);
part_type_size(global.flame_particle, 0.5, 1.5, -0.1, 0);
part_type_orientation(global.flame_particle, 0, 360, 5, 0, 0);
part_type_color2(global.flame_particle, c_orange, c_red);
part_type_alpha3(global.flame_particle, 1, 1, 0);
part_type_blend(global.flame_particle, 1);
part_type_direction(global.flame_particle, 85, 95, 0, 0);
part_type_speed(global.flame_particle, 0.2, 1.5, -0.05, 0);
part_type_life(global.flame_particle, 15, 20);

// Flamedash particle
global.dash_particle = part_type_create();
part_type_sprite(global.dash_particle, sprFireSmall, 0, 0, 1);
part_type_size(global.dash_particle, 0.5, 1.5, -0.1, 0);
part_type_orientation(global.dash_particle, 0, 360, 5, 0, 0);
part_type_color2(global.dash_particle, c_orange, c_red);
part_type_alpha3(global.dash_particle, 1, 1, 0);
part_type_blend(global.dash_particle, 1);
part_type_direction(global.dash_particle, 90, 90, 0, 0);
part_type_speed(global.dash_particle, 0.2, 1.5, -0.05, 0);
part_type_life(global.dash_particle, 15, 20);
part_type_gravity(global.dash_particle, 0.3, 90);

// Shockwave particle
global.shockwave_particle = part_type_create();
part_type_shape(global.shockwave_particle, pt_shape_ring);
part_type_scale(global.shockwave_particle, 0.2, 0.2);
part_type_size(global.shockwave_particle, 1, 1, 1, 0);
part_type_orientation(global.shockwave_particle, 0, 0, 0, 0, 0);
part_type_color1(global.shockwave_particle, c_white);
part_type_alpha2(global.shockwave_particle, 0.1, 0);
part_type_blend(global.shockwave_particle, 0);
part_type_direction(global.shockwave_particle, 0, 0, 0, 0);
part_type_speed(global.shockwave_particle, 0, 0, 0, 0);
part_type_life(global.shockwave_particle, 7, 7);
part_type_gravity(global.shockwave_particle, 0, 0);

// Play some meme song?

//audio_play_sound(mscMenu, 10, true);