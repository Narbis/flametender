if (!cooldown && objPlayer.flame < objPlayer.flame_max)
{
	cooldown = true;
	sprite_index = sprFlameRestorePickupBurst;
	
	objPlayer.flame += 1;
}