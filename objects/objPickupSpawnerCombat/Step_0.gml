if(!instance_exists(objEnemy) && !spawned)
{
	if (objPlayer.lifepickups[pickup_number] == false)
	{
		var instance = instance_create_layer(x, y, "Player", objLifePickup);
		with (instance)
		{
			life_pickup_num = other.pickup_number;
		}
		spawned = true;
	}
}