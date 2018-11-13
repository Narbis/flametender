/// ChangeRoom(room, x, y)
/// @description ChangeRoom(room, x, y)
/// @param room
/// @param x
/// @param y

// Moves player to position x,y in room
room_goto(argument0);
objPlayer.x = argument1;
objPlayer.y = argument2;

// Reset state variables

if (objPlayer.state != player_states.hurt)
{
	objPlayer.state = player_states.idle;
	objPlayer.reset_animation = true;
	objPlayer.image_speed = 1;
}

// Clear remaining particles
part_particles_clear(global.particle_system);