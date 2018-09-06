if(facing_right)
{
	instance_create_layer(x + 4, y, "Player", objFireballHit);
}
else
{
	instance_create_layer(x - 4, y, "Player", objFireballHit);
}

instance_destroy();