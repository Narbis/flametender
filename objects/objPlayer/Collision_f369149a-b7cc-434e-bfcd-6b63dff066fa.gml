// Collision with an enemy hitbox will overwrite whatever state the player is currently in

if (state != player_states.dead)
{
	state = player_states.hurt;
}