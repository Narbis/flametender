follow = noone;
if (instance_exists(objPlayer))
{
	follow = objPlayer;
}

x_motion = 0;
y_motion = 0;

player_previous_x = objPlayer.x;
player_previous_y = objPlayer.y;

player_x_sign = sign(follow.image_xscale);
image_xscale = 1;
image_yscale = 1;

duration = 30;
life_counter = 0;
size = 0.1;

// Fire attack particle
attack_particle = part_type_create();
part_type_sprite(attack_particle, sprFire, 0, 0, 1);
part_type_size(attack_particle, size - 0.02, size + 0.02, 0.15, 0);
part_type_orientation(attack_particle, 0, 360, 5, 0, 0);
part_type_color2(attack_particle, c_orange, c_red);
part_type_alpha3(attack_particle, 1, 1, 0);
part_type_blend(attack_particle, 1);
part_type_direction(attack_particle, 80, 100, 0, 0);
part_type_speed(attack_particle, 0.01, 0.05, 0.005, 0);
part_type_life(attack_particle, 5, 10);
part_type_gravity(attack_particle, 0.2, 90);