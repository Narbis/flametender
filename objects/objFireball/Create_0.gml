facing_right = objPlayer.face_right;
life_counter = 0;
size = 0.2;

// TEST

// Fire attack particle
attack_particle = part_type_create();
part_type_sprite(attack_particle, sprFireSmall, 0, 0, 1);
part_type_size(attack_particle, size - 0.1, size + 0.1, 0.15, 0);
part_type_orientation(attack_particle, 0, 360, 5, 0, 0);
part_type_color2(attack_particle, c_orange, c_red);
part_type_alpha3(attack_particle, 1, 1, 0);
part_type_blend(attack_particle, 1);
part_type_direction(attack_particle, 0, 0, 0, 0);
part_type_speed(attack_particle, 0, 0.5, -0.1, 0);
part_type_life(attack_particle, 5, 10);
part_type_gravity(attack_particle, 0.2, 90);