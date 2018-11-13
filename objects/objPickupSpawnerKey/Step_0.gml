if(!instance_exists(objEnemy) && !spawned)
{
	if (objPlayer.key == false)
	{
		instance_create_layer(x, y, "Player", objKeyPickup);
		spawned = true;
	}
}