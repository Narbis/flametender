if ((!cooldown && !respawning) && objPlayer.flame < objPlayer.flame_max)
{
	cooldown = true;
	sprite_index = sprFlameRestorePickupBurst;
	scrPlaySound(sndFlameRestorePickup, x, y);
	
	objPlayer.flame += 1;
}