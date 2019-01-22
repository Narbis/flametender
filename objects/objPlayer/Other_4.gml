if (checkpoint_set && room == checkpoint_room)
{
	instance_create_layer(checkpoint_x, checkpoint_y, "Player", objCheckpoint);
}