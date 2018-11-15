if(!instance_exists(objEnemy) && !spawned)
{
	instance_create_layer(x, y, "Player", objKeyPickup);
	spawned = true;
}