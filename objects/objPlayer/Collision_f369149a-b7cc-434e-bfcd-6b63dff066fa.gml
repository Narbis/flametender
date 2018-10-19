// Collision with an enemy hitbox will overwrite whatever state the player is currently in

if (state != player_states.dead && !invuln)
{
	state = player_states.hurt;
	invuln = true;
	
	v_speed = -2;
	h_speed = 2 * sign(x - other.x);
	life -= 1;
}