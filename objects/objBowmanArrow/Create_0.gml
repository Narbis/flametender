face_right = true;
move_speed = 5;

arrow_deflect_particle = part_type_create();
part_type_sprite(arrow_deflect_particle, sprBowmanArrowDeflect, 1, 1, 0);
part_type_scale(arrow_deflect_particle, 1, 1);
part_type_alpha2(arrow_deflect_particle, 1, 0);
part_type_life(arrow_deflect_particle, 30, 30);